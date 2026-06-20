//
//  AuthPlugin.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//

// 모든 API 요청에 Keychain의 accessToken을 헤더에 자동으로 첨부하는 플러그인

import Foundation
import Moya

// MARK: - 인증 토큰 자동 첨부 플러그인
struct AuthPlugin: PluginType {

    // MARK: - 요청 직전에 Authorization 헤더 추가
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        guard let token = KeychainService.load(key: KeychainService.Keys.accessToken) else {
            return request  // 토큰 없으면 헤더 없이 그대로 전송
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")  // Bearer 토큰 헤더 첨부
        return request
    }
}
