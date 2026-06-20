//
//  WeatherResponseDTO.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//
// 날씨 조회 API 응답 모델
import Foundation

// MARK: - 날씨 조회 응답
struct WeatherObservationResponse: Decodable {
    let weather: AppLaunchWeatherData   // 날씨/자외선 정보 (AppLaunchModel 공용)
    let egg: AppLaunchEggData           // 계란 상태 (AppLaunchModel 공용)
    let outingStart: OutingStartData    // 외출 시작 가능 여부 (AppLaunchModel 공용)
    let notification: NotificationCount // 읽지 않은 알림 수 (OutingModel 공용)
}
