//
//  AlertViewModel.swift
//  EggWatch
//
//  Created by 최윤석 on 6/20/26.
//
//  알림함 화면 ViewModel
//  AlertService 호출, 응답 바인딩 담당

import Foundation
import SwiftUI
import Combine

// MARK: - 알림함 ViewModel
@MainActor
final class AlertViewModel: ObservableObject {

    // MARK: - 알림함 데이터
    @Published var notifications: [NotificationItem] = []   // 읽지 않은 알림 목록 (최신순)
    @Published var unreadCount: Int = 0                     // 읽지 않은 알림 개수
    @Published var emptyMessage: String?                    // 알림이 없을 때 표시할 문구

    // MARK: - 상태
    @Published var isLoading: Bool = false                  // 로딩 상태
    @Published var errorMessage: String?                    // 에러 메시지 (화면 노출용)

    // MARK: - 의존성
    private let alertService: AlertService

    // MARK: - 초기화
    init(alertService: AlertService? = nil) {
        self.alertService = alertService ?? AlertService()
    }

    // MARK: - 알림 목록 조회 (3.11)
    // AlertView 진입 시(onAppear), pull-to-refresh 시 호출
    // 읽지 않은 알림(isRead=false)만 최신순으로 받음
    func fetchNotifications() {
        isLoading = true
        errorMessage = nil

        alertService.fetchNotifications { [weak self] result in
            Task { @MainActor in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.notifications = response.notifications     // 알림 목록 바인딩
                    self.unreadCount = response.unreadCount         // 읽지 않은 개수 갱신
                    self.emptyMessage = response.emptyMessage       // 알림 없을 때 안내 문구
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
