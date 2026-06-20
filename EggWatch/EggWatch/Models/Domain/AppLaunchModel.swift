//
//  AppLaunchModel.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//
// 앱 재실행 API 요청/응답 모델
import Foundation

// MARK: - 앱 실행 요청
struct AppLaunchRequest: Encodable {
    let latitude: Double    // 현재 위도
    let longitude: Double   // 현재 경도
}

// MARK: - 앱 실행 응답
struct AppLaunchResponse: Decodable {
    let nextScreen: NextScreen              // HOME 또는 OUTING
    let home: AppLaunchHomeData?            // 홈 모드 진입 시 데이터
    let outing: OutingContext?              // 외출 모드 진입 시 데이터 (OutingModel 공용)
    let endedSession: EndedSessionInfo?     // 자동 종료된 세션 정보 (OutingModel 공용)
    let autoEndNotice: AutoEndNotice?       // 자동 종료 팝업 정보 (OutingModel 공용)
}

// MARK: - 홈 모드 데이터
struct AppLaunchHomeData: Decodable {
    let weather: AppLaunchWeatherData   // 날씨 정보
    let egg: AppLaunchEggData           // 계란 상태
    let outingStart: OutingStartData    // 외출 시작 가능 여부
    let notification: NotificationCount // 읽지 않은 알림 수 (OutingModel 공용)
}

// MARK: - 날씨 데이터 (홈용)
struct AppLaunchWeatherData: Decodable {
    let locationName: String        // 지역명
    let weatherType: String         // 날씨 종류 (CLEAR, RAIN 등)
    let weatherLabel: String        // 날씨 표시 문구
    let temperatureCelsius: Double  // 기온
    let uvIndex: Double             // 자외선 지수
    let uvLevel: String             // 자외선 단계 (LOW, HIGH 등)
    let uvLevelLabel: String        // 자외선 단계 표시 문구
}

// MARK: - 계란 상태 (홈용)
struct AppLaunchEggData: Decodable {
    let eggStatus: String       // 계란 상태 (SAFE, TOASTED 등)
    let eggStatusLabel: String  // 계란 상태 표시 문구
    let message: String         // 화면 표시 메시지
}

// MARK: - 외출 시작 가능 여부
struct OutingStartData: Decodable {
    let canStart: Bool              // 외출 시작 가능 여부
    let unavailableMessage: String? // 불가 시 표시 메시지
}
