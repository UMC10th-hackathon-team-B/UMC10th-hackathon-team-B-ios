//
//  NotificationRouter.swift
//  EggWatch
//
//  Created by 최윤석 on 6/20/26.
//

import Foundation
import Moya
import Alamofire

// MARK: - 알림 엔드포인트 종류
enum NotificationRouter {
    case getList                                            // 알림함 조회 (3.11)
    case markAsRead(notificationId: Int, isRead: Bool)      // 알림 읽음 처리 (3.12)
}

// MARK: - Moya TargetType 설정
extension NotificationRouter: TargetType {

    // MARK: - 기본 URL
    var baseURL: URL {
        URL(string: "https://api.warnning-egg.r-e.kr/")!
    }

    // MARK: - 엔드포인트 경로
    var path: String {
        switch self {
        case .getList:
            return "api/v1/notifications"
        case .markAsRead(let notificationId, _):
            return "api/v1/notifications/\(notificationId)"
        }
    }

    // MARK: - HTTP 메서드
    var method: Moya.Method {
        switch self {
        case .getList:    return .get
        case .markAsRead: return .patch
        }
    }

    // MARK: - 요청 body
    var task: Task {
        switch self {
        case .getList:
            return .requestPlain
        case .markAsRead(_, let isRead):
            return .requestJSONEncodable(MarkAsReadRequest(isRead: isRead))
        }
    }

    // MARK: - 요청 헤더
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
