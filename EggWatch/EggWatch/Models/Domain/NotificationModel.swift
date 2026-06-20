//
//  NotificationModel.swift
//  EggWatch
//
//  Created by 최윤석 on 6/20/26.
//
//  알림함 조회/읽음 처리 API 요청/응답 모델

import Foundation

// MARK: - 알림 읽음 처리 요청 (3.12)
struct MarkAsReadRequest: Encodable {
    let isRead: Bool
}

// MARK: - 알림 목록 응답 (3.11, 3.12 공통)
struct NotificationListResponse: Decodable {
    let unreadCount: Int
    let notifications: [NotificationItem]
    let emptyMessage: String?
}

// MARK: - 알림 항목
struct NotificationItem: Decodable, Identifiable {
    let notificationId: Int
    let type: NotificationType
    let title: String
    let content: String
    let createdAt: String
    let createdTimeText: String
    let isRead: Bool

    var id: Int { notificationId }
}

// MARK: - 알림 타입
enum NotificationType: String, Decodable {
    case dailyUV   = "DAILY_UV"
    case eggDanger = "EGG_DANGER"
}
