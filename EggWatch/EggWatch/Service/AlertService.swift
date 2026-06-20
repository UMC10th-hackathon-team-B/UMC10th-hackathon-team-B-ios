//
//  AlertService.swift
//  EggWatch
//
//  Created by 최윤석 on 6/20/26.
//

import Foundation
import Moya

class AlertService {

    private let provider = MoyaProvider<NotificationRouter>(plugins: [
        AuthPlugin(),
        TokenRefreshPlugin()
    ])

    func fetchNotifications(completion: @escaping (Result<NotificationListResponse, Error>) -> Void) {
        provider.request(.getList) { result in
            switch result {
            case .success(let response):
                guard let wrapped = try? response.map(APIResponse<NotificationListResponse>.self) else {
                    completion(.failure(AlertError.parseFailed))
                    return
                }
                if let data = wrapped.data {
                    completion(.success(data))
                } else if wrapped.code == APIError.notification404.rawValue {
                    // 읽지 않은 알림 없음 — 빈 목록으로 정상 처리
                    completion(.success(NotificationListResponse(
                        unreadCount: 0,
                        notifications: [],
                        emptyMessage: wrapped.message
                    )))
                } else {
                    completion(.failure(AlertError.parseFailed))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func markAsRead(notificationId: Int,
                    completion: @escaping (Result<NotificationListResponse, Error>) -> Void) {
        provider.request(.markAsRead(notificationId: notificationId, isRead: true)) { result in
            switch result {
            case .success(let response):
                guard let wrapped = try? response.map(APIResponse<NotificationListResponse>.self) else {
                    completion(.failure(AlertError.parseFailed))
                    return
                }
                if let data = wrapped.data {
                    completion(.success(data))
                } else if wrapped.code == APIError.notification404.rawValue {
                    completion(.success(NotificationListResponse(
                        unreadCount: 0,
                        notifications: [],
                        emptyMessage: wrapped.message
                    )))
                } else {
                    completion(.failure(AlertError.parseFailed))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - 알림 서비스 에러
enum AlertError: LocalizedError {
    case parseFailed

    var errorDescription: String? {
        switch self {
        case .parseFailed: return "알림을 불러오지 못했어요. 잠시 후 다시 시도해주세요."
        }
    }
}

