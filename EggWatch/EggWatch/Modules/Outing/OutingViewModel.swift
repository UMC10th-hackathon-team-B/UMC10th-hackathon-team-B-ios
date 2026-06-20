//
//  OutingViewModel.swift
//  EggWatch
//
//  Created by 최윤석 on 6/20/26.
//
//  외출 모드 화면 ViewModel
//  OutingService 호출, 응답 바인딩, 자동 종료 분기 처리 담당

import Foundation
import SwiftUI
import Combine

// MARK: - 외출 모드 ViewModel
@MainActor
final class OutingViewModel: ObservableObject {

    // MARK: - 외출 화면 데이터
    @Published var outingContext: OutingContext?      // 외출 세션/날씨/계란/선크림/알림 카운트
    @Published var isLoading: Bool = false            // 로딩 상태
    @Published var errorMessage: String?              // 에러 메시지 (화면에 노출용)

    // MARK: - 팝업 상태
    @Published var showSunscreenConfirm: Bool = false    // 선크림 기록 확인 팝업 표시 여부
    @Published var showEndConfirm: Bool = false          // 외출 종료 확인 팝업 표시 여부
    @Published var showAutoEndPopup: Bool = false        // 자동 종료 안내 팝업 표시 여부 (1.6)
    @Published var showUVNotAvailablePopup: Bool = false // 이용 제한 시간 안내 팝업 표시 여부 (OUTING_400)

    // MARK: - 종료 정보
    @Published var endedSession: EndedSessionInfo?       // 종료된 세션 정보 (수동/자동/로그아웃)
    @Published var autoEndNotice: AutoEndNotice?         // 자동 종료 안내 문구
    @Published var shouldNavigateToHome: Bool = false    // 홈 모드로 이동해야 하는지 (종료 후)

    // MARK: - 의존성
    private let outingService: OutingService
    private let locationService: LocationService

    // MARK: - 초기화
    init(outingService: OutingService? = nil,
         locationService: LocationService) {
        self.outingService = outingService ?? OutingService()
        self.locationService = locationService
    }
}
