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

    // MARK: - 외출 세션 시작 (3.7)
    // UVSelectionView 또는 외출 시작 화면에서 호출
    // 이용 제한 시간(저녁 8시 이후, OUTING_400) 등 시작 불가 상황에서 UVNotAvailablePopup 표시
    func startOuting(sunscreenAppliedOption: SunscreenAppliedOption) {
        isLoading = true
        errorMessage = nil
        let latitude = locationService.latitude
        let longitude = locationService.longitude

        outingService.startOuting(sunscreenAppliedOption: sunscreenAppliedOption,
                                  latitude: latitude,
                                  longitude: longitude) { [weak self] result in
            Task { @MainActor in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.handleOutingResponse(response)        // 정상/자동 종료 분기 처리
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.showUVNotAvailablePopup = true        // 이용 제한 시간 등 외출 시작 불가 안내
                }
            }
        }
    }

    // MARK: - 외출 화면 조회/새로고침 (3.8)
    // onAppear 진입 시, pull-to-refresh 시 호출
    // 자동 종료 응답 분기 처리는 이후 단계에서 추가
    func fetchCurrent() {
        isLoading = true
        errorMessage = nil
        let latitude = locationService.latitude
        let longitude = locationService.longitude

        outingService.fetchCurrent(latitude: latitude, longitude: longitude) { [weak self] result in
            Task { @MainActor in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.handleOutingResponse(response)        // 정상/자동 종료 분기 처리
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - 자외선 차단제 다시 바르기 기록 (3.9)
    // SuncreamConfirmView 확인 버튼 탭 시 호출
    // 자동 종료 응답 분기 처리는 이후 단계에서 추가
    func applySunscreen() {
        isLoading = true
        errorMessage = nil
        let latitude = locationService.latitude
        let longitude = locationService.longitude

        outingService.applySunscreen(latitude: latitude, longitude: longitude) { [weak self] result in
            Task { @MainActor in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.showSunscreenConfirm = false          // 확인 팝업 닫기
                    self.handleOutingResponse(response)        // 정상/자동 종료 분기 처리
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - 외출 세션 직접 종료 (3.10)
    // OutingEndConfirmView 확인 버튼 탭 시 호출
    // 종료 후 홈 화면으로 이동 트리거 (shouldNavigateToHome = true)
    // 자동 종료 안내(autoEndNotice) 분기 처리는 이후 단계에서 추가
    func endOuting() {
        guard let sessionId = outingContext?.outingSession.outingSessionId else {
            errorMessage = "외출 세션 정보를 찾을 수 없어요."
            return
        }

        isLoading = true
        errorMessage = nil
        let latitude = locationService.latitude
        let longitude = locationService.longitude

        outingService.endOuting(outingSessionId: sessionId,
                                latitude: latitude,
                                longitude: longitude) { [weak self] result in
            Task { @MainActor in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.endedSession = response.endedSession                       // 종료된 세션 정보 보관
                    self.autoEndNotice = response.autoEndNotice                     // 자동 종료 시에만 값 존재
                    self.showAutoEndPopup = response.autoEndNotice?.showPopup ?? false // 자동 종료 안내 팝업 표시 여부
                    self.showEndConfirm = false                                     // 확인 팝업 닫기
                    self.shouldNavigateToHome = true                                // 홈 모드로 이동 트리거
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - 외출 응답 분기 처리 (1.6)
    // 자동 종료 시간 경과 응답이면 endedSession이 채워져 있고 nextScreen=HOME
    // - 자동 종료: endedSession/autoEndNotice 저장 후 홈 이동 트리거, 필요 시 안내 팝업 표시
    // - 정상 응답: outingContext만 갱신
    private func handleOutingResponse(_ response: OutingResponse) {
        if response.nextScreen == .home, let endedSession = response.endedSession {
            self.endedSession = endedSession
            self.autoEndNotice = response.autoEndNotice
            self.showAutoEndPopup = response.autoEndNotice?.showPopup ?? false
            self.shouldNavigateToHome = true
        } else {
            self.outingContext = response.outing
        }
    }
}
