//
//  KeychainService.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//

import Foundation
import Security

// MARK: - JWT 토큰을 안전하게 저장/불러오기/삭제하는 서비스
struct KeychainService {

    // MARK: - 저장할 토큰 키 이름
    enum Keys {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }

    // MARK: - 토큰 저장
    static func save(key: String, value: String) {
        let data = Data(value.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)    // 기존 값 삭제 후 새로 저장
        SecItemAdd(query as CFDictionary, nil)
    }

    // MARK: - 토큰 불러오기
    static func load(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        guard SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess,
              let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    // MARK: - 토큰 삭제 (로그아웃 시 사용)
    static func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
