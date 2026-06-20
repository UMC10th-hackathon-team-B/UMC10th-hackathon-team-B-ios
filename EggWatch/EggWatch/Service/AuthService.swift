//
//  AuthService.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//
// 인증 관련 API 호출 서비스 (로그아웃, 토큰 재발급)

import Foundation
import Moya

// MARK: - 인증 서비스
class AuthService {

    private let provider = MoyaProvider<AuthRouter>(plugins: [
        AuthPlugin(),           // accessToken 헤더 자동 첨부
        TokenRefreshPlugin(),   // 401 시 자동 재발급
        NetworkLoggerPlugin()   // 상세 요청/응답 로그
    ])

    // MARK: - 로그아웃 API 호출
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let refreshToken = KeychainService.load(key: KeychainService.Keys.refreshToken) else {
            completion(.failure(NSError(domain: "Auth", code: -1)))  // 토큰 없으면 실패
            return
        }
        provider.request(.logout(refreshToken: refreshToken)) { result in
            switch result {
            case .success(let response):
                print("✅ 로그아웃 성공 - 상태코드: \(response.statusCode)")
                completion(.success(()))
            case .failure(let error):
                print("❌ 로그아웃 실패 - \(error)")
                completion(.failure(error))
            }
        }
    }
}
