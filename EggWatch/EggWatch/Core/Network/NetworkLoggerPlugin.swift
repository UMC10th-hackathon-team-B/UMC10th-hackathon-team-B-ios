//
//  NetworkLoggerPlugin.swift
//  EggWatch
//
//  Created by 한지민 on 6/21/26.
//
// 백엔드 디버깅용 상세 네트워크 로그 플러그인

import Foundation
import Moya

struct NetworkLoggerPlugin: PluginType {

    func willSend(_ request: RequestType, target: TargetType) {
        guard let urlRequest = request.request else { return }

        print("\n========== 📤 REQUEST ==========")
        print("METHOD : \(urlRequest.httpMethod ?? "-")")
        print("URL    : \(urlRequest.url?.absoluteString ?? "-")")

        if let headers = urlRequest.allHTTPHeaderFields, !headers.isEmpty {
            print("HEADERS:")
            for (key, value) in headers {
                if key == "Authorization" {
                    let masked = maskToken(value)
                    print("  \(key): \(masked)")
                } else {
                    print("  \(key): \(value)")
                }
            }
        }

        if let body = urlRequest.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("BODY   : \(bodyString)")
        }
        print("=================================\n")
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            print("\n========== 📥 RESPONSE ==========")
            print("STATUS : \(response.statusCode)")

            if let headers = response.response?.allHeaderFields as? [String: String], !headers.isEmpty {
                print("HEADERS:")
                for (key, value) in headers {
                    print("  \(key): \(value)")
                }
            }

            if let bodyString = String(data: response.data, encoding: .utf8) {
                print("BODY   : \(bodyString)")
            }
            print("==================================\n")

        case .failure(let error):
            print("\n========== ❌ RESPONSE ERROR ==========")
            if let response = error.response {
                print("STATUS : \(response.statusCode)")
                if let bodyString = String(data: response.data, encoding: .utf8) {
                    print("BODY   : \(bodyString)")
                }
            }
            print("ERROR  : \(error)")
            print("=======================================\n")
        }
    }

    // Authorization 토큰 앞 10자리, 뒤 4자리만 보이고 중간 마스킹
    private func maskToken(_ value: String) -> String {
        let prefix = "Bearer "
        guard value.hasPrefix(prefix) else { return value }
        let token = String(value.dropFirst(prefix.count))
        guard token.count > 14 else { return "\(prefix)****" }
        let start = String(token.prefix(10))
        let end = String(token.suffix(4))
        return "\(prefix)\(start)...\(end)"
    }
}
