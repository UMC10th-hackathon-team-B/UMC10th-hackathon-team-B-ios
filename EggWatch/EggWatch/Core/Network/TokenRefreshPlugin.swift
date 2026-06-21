//
//  TokenRefreshPlugin.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//

import Foundation
import Moya

struct TokenRefreshPlugin: PluginType {

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        guard case .success(let response) = result,
              response.statusCode == 401 else { return }

        refreshToken()
    }

    private func refreshToken() {
        guard let refreshToken = KeychainService.load(key: KeychainService.Keys.refreshToken) else {
            forceLogout()
            return
        }

        let provider = MoyaProvider<AuthRouter>()
        provider.request(.refreshToken(refreshToken: refreshToken)) { result in
            switch result {
            case .success(let response):
                guard let wrapped = try? response.map(APIResponse<AuthTokens>.self),
                      let tokens = wrapped.data else {
                    // Refresh 토큰도 만료 → 강제 로그아웃
                    forceLogout()
                    return
                }
                KeychainService.save(key: KeychainService.Keys.accessToken, value: tokens.accessToken)
                KeychainService.save(key: KeychainService.Keys.refreshToken, value: tokens.refreshToken)
            case .failure:
                forceLogout()
            }
        }
    }

    private func forceLogout() {
        DispatchQueue.main.async {
            KeychainService.delete(key: KeychainService.Keys.accessToken)
            KeychainService.delete(key: KeychainService.Keys.refreshToken)
            NotificationCenter.default.post(name: .forceLogout, object: nil)
        }
    }
}

extension Notification.Name {
    static let forceLogout = Notification.Name("forceLogout")
}
