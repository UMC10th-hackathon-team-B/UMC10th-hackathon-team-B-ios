//
//  TokenRefreshPlugin.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//

// 401 에러 시 자동으로 토큰을 재발급받아 재요청하는 플러그인

import Foundation
import Moya

// MARK: - 토큰 자동 재발급 플러그인
struct TokenRefreshPlugin: PluginType {

    // MARK: - 응답 받은 후 401이면 토큰 재발급 시도
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        guard case .success(let response) = result,
              response.statusCode == 401 else { return }  // 401 아니면 무시

        refreshToken()  // 토큰 재발급 시도
    }

    // MARK: - 토큰 재발급 요청
    private func refreshToken() {
        guard let refreshToken = KeychainService.load(key: KeychainService.Keys.refreshToken) else { return }  // 저장된 refreshToken 없으면 종료

        let provider = MoyaProvider<AuthRouter>()
        provider.request(.refreshToken(refreshToken: refreshToken)) { result in
            switch result {
            case .success(let response):
                guard let wrapped = try? response.map(APIResponse<AuthTokens>.self),
                      let tokens = wrapped.data else {
                    print("❌ 토큰 재발급 파싱 실패 - 상태코드: \(response.statusCode)")
                    return
                }
                print("✅ 토큰 재발급 성공")
                KeychainService.save(key: KeychainService.Keys.accessToken, value: tokens.accessToken)
                KeychainService.save(key: KeychainService.Keys.refreshToken, value: tokens.refreshToken)
            case .failure(let error):
                print("❌ 토큰 재발급 실패 - \(error)")
            }
        }
    }
}
