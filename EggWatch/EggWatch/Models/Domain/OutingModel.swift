//
//  OutingModel.swift
//  EggWatch
//
//  Created by 최윤석 on 6/20/26.
//
//  외출 모드 관련 API 요청/응답 모델 정의

import Foundation

// MARK: - 외출 시작 요청 (3.7)
struct OutingStartRequest: Encodable {
    let sunscreenAppliedOption: SunscreenAppliedOption
    let latitude: Double
    let longitude: Double
}

// MARK: - 외출 종료 요청 (3.10)
struct OutingEndRequest: Encodable {
    let status: OutingSessionStatus
    let latitude: Double
    let longitude: Double
}

// MARK: - 선크림 다시 바르기 기록 요청 (3.9)
struct SunscreenApplicationRequest: Encodable {
    let latitude: Double
    let longitude: Double
}

// MARK: - 외출 공통 응답 (3.7, 3.8, 3.9)
// 정상 응답: outing 필드 / 자동 종료 응답(1.6): endedSession + autoEndNotice 필드
struct OutingResponse: Decodable {
    let nextScreen: NextScreen
    let outing: OutingContext?
    let endedSession: EndedSessionInfo?
    let autoEndNotice: AutoEndNotice?
}

// MARK: - 외출 직접 종료 응답 (3.10)
struct OutingEndResponse: Decodable {
    let nextScreen: NextScreen
    let endedSession: EndedSessionInfo
    let autoEndNotice: AutoEndNotice?
}

// MARK: - 외출 컨텍스트 (외출 모드 화면 데이터)
struct OutingContext: Decodable {
    let outingSession: OutingSessionInfo
    let weather: OutingWeatherInfo
    let egg: EggInfo
    let sunscreen: SunscreenInfo
    let notification: NotificationCount
}

// MARK: - 외출 세션 정보
struct OutingSessionInfo: Decodable {
    let outingSessionId: Int
    let startedAt: String
    let autoEndAt: String
    let elapsedMinutes: Int
    let elapsedTimeText: String
}

// MARK: - 종료된 세션 정보 (자동 종료 또는 수동 종료)
struct EndedSessionInfo: Decodable {
    let outingSessionId: Int
    let status: OutingSessionStatus
    let endReason: EndReason
    let startedAt: String
    let endedAt: String
    let elapsedMinutes: Int
    let elapsedTimeText: String
}

// MARK: - 외출 화면용 날씨 정보
// 기존 WeatherInfo와 이름 충돌 회피를 위해 Outing 프리픽스 사용
struct OutingWeatherInfo: Decodable {
    let locationName: String
    let weatherType: WeatherType
    let weatherLabel: String
    let temperatureCelsius: Double
    let uvIndex: Double
    let uvLevel: APIUVLevel
    let uvLevelLabel: String
}

// MARK: - 계란 정보
struct EggInfo: Decodable {
    let eggStatus: EggStatus
    let eggStatusLabel: String
    let message: String
}

// MARK: - 선크림 정보
struct SunscreenInfo: Decodable {
    let lastSunscreenAppliedAt: String?
    let lastSunscreenAppliedElapsedMinutes: Int?
    let lastSunscreenAppliedText: String
}

// MARK: - 자동 종료 안내
struct AutoEndNotice: Decodable {
    let showPopup: Bool
    let title: String
    let message: String
}

// MARK: - 알림 카운트
struct NotificationCount: Decodable {
    let unreadCount: Int
}

// MARK: - 선크림 사용 시점 옵션
enum SunscreenAppliedOption: String, Codable {
    case none = "NONE"
    case before5Minutes = "BEFORE_5_MINUTES"
    case before15Minutes = "BEFORE_15_MINUTES"
    case before30Minutes = "BEFORE_30_MINUTES"
    case before60Minutes = "BEFORE_60_MINUTES"
    case before120Minutes = "BEFORE_120_MINUTES"

    var displayText: String {
        switch self {
        case .none:             return "안 발랐어요"
        case .before5Minutes:   return "5분 전"
        case .before15Minutes:  return "15분 전"
        case .before30Minutes:  return "30분 전"
        case .before60Minutes:  return "1시간 전"
        case .before120Minutes: return "2시간 전"
        }
    }
}

// MARK: - 날씨 타입 (15종)
enum WeatherType: String, Decodable {
    case thunderstorm = "THUNDERSTORM"
    case drizzle      = "DRIZZLE"
    case rain         = "RAIN"
    case snow         = "SNOW"
    case mist         = "MIST"
    case smoke        = "SMOKE"
    case haze         = "HAZE"
    case dust         = "DUST"
    case fog          = "FOG"
    case sand         = "SAND"
    case ash          = "ASH"
    case squall       = "SQUALL"
    case tornado      = "TORNADO"
    case clear        = "CLEAR"
    case clouds       = "CLOUDS"
}

// MARK: - 자외선 지수 단계 (API용)
// 기존 UVLevel과 이름 충돌 회피, A 담당자가 Common/Enum/UVLevel.swift 정리 후 통합 예정
enum APIUVLevel: String, Decodable {
    case low      = "LOW"
    case normal   = "NORMAL"
    case high     = "HIGH"
    case veryHigh = "VERY_HIGH"
    case danger   = "DANGER"
}

// MARK: - 외출 세션 상태
enum OutingSessionStatus: String, Codable {
    case inProgress = "IN_PROGRESS"
    case completed  = "COMPLETED"
}

// MARK: - 종료 사유
enum EndReason: String, Decodable {
    case manual = "MANUAL"
    case auto   = "AUTO"
    case logout = "LOGOUT"
}

// MARK: - 계란 상태
enum EggStatus: String, Decodable {
    case safe         = "SAFE"
    case lightToasted = "LIGHT_TOASTED"
    case toasted      = "TOASTED"
    case burned       = "BURNED"
    case danger       = "DANGER"
}
