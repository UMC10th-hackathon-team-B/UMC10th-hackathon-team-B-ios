//
//  AlertService.swift
//  EggWatch
//
//  Created by JOON on 6/17/26.
//
//  알림함 조회/읽음 처리 API를 호출하는 서비스

import Foundation
import Moya

// MARK: - 알림 서비스
class AlertService {

    // MARK: - Moya Provider
    // AuthPlugin: accessToken 헤더 자동 첨부
    // TokenRefreshPlugin: 401 시 자동 재발급
    private let provider = MoyaProvider<NotificationRouter>(plugins: [
        AuthPlugin(),
        TokenRefreshPlugin()
    ])

    // MARK: - 알림함 조회 API 호출 (3.11)
    // 읽지 않은 알림(isRead=false)만 최신순으로 반환됨
    func fetchNotifications(completion: @escaping (Result<NotificationListResponse, Error>) -> Void) {
        provider.request(.getList) { result in
            switch result {
            case .success(let response):
                guard let wrapped = try? response.map(APIResponse<NotificationListResponse>.self),
                      let data = wrapped.data else {
                    completion(.failure(NSError(domain: "Notification", code: -1))) // 파싱 실패
                    return
                }
                completion(.success(data))  // 성공 시 알림 목록 전달
            case .failure(let error):
                completion(.failure(error)) // 실패 시 에러 전달
            }
        }
    }
}
