//
//  APIProviderStore.swift
//  EggWatch
//
//  Created by JOON on 6/18/26.
//

// AuthPlugin, TokenRefreshPlugin이 적용된 Provider 싱글톤 저장소
import Foundation
import Moya

// MARK: - Provider 싱글톤
struct APIProviderStore {
    // MARK: - 인증 필요한 API용 Provider (AuthPlugin + TokenRefreshPlugin 적용)
    static let authenticated = MoyaProvider<AuthRouter>(plugins: [
        AuthPlugin(),           // 모든 요청에 accessToken 헤더 자동 첨부
        TokenRefreshPlugin()    // 401 에러 시 자동 토큰 재발급
    ])

    // MARK: - 인증 불필요한 API용 Provider (로그인, 회원가입 등)
    static let `default` = MoyaProvider<AuthRouter>()  // 플러그인 없는 기본 Provider
}
