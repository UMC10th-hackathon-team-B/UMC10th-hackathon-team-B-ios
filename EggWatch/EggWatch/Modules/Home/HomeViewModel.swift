//
//  HomeViewModel.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//
// 홈 화면 날씨/자외선 데이터를 관리하는 뷰모델

import Foundation
import Combine

// MARK: - 홈 뷰모델
class HomeViewModel: ObservableObject {

    private let weatherService = WeatherService()       // 날씨 서비스
    private let locationService = LocationService()     // 위치 서비스
    private var cancellables = Set<AnyCancellable>()    // Combine 구독 저장소

    @Published var weather: AppLaunchWeatherData? = nil     // 날씨 데이터
    @Published var egg: AppLaunchEggData? = nil             // 계란 상태
    @Published var outingStart: OutingStartData? = nil      // 외출 시작 가능 여부
    @Published var unreadCount: Int = 0                     // 읽지 않은 알림 수
    @Published var isLoading: Bool = true                   // 로딩 중 여부
    @Published var errorMessage: String? = nil              // 에러 메시지

    init() {
        // 위치 가져오면 날씨 API 자동 호출
        locationService.$latitude
            .combineLatest(locationService.$longitude)
            .filter { lat, lon in lat != 0.0 && lon != 0.0 }   // 유효한 위치일 때만
            .first()                                             // 한 번만 호출
            .sink { [weak self] lat, lon in
                self?.fetchWeather(latitude: lat, longitude: lon)
            }
            .store(in: &cancellables)

        locationService.fetchOnce()     // 위치 요청
    }

    // MARK: - 날씨 조회
    func fetchWeather(latitude: Double, longitude: Double) {
        isLoading = true
        weatherService.fetchWeather(latitude: latitude, longitude: longitude) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let data):
                    self?.weather = data.weather            // 날씨 정보 저장
                    self?.egg = data.egg                    // 계란 상태 저장
                    self?.outingStart = data.outingStart    // 외출 가능 여부 저장
                    self?.unreadCount = data.notification.unreadCount   // 알림 수 저장
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription     // 에러 저장
                }
            }
        }
    }

    // MARK: - 날씨 새로고침
    func refresh() {
        locationService.fetchOnce()     // 위치 다시 가져와서 날씨 갱신
    }
}
