//임시 모델
import SwiftUI

struct WeatherInfo {
    var location: String = "강남구"
    var temperature: Int = 27
    var condition: String = "맑음"
    var uvIndex: Int = 7
    var uvLevel: UVLevel = .high
}

enum UVLevel: String {
    case low = "낮음"
    case moderate = "보통"
    case high = "높음"
    case veryHigh = "매우 높음"
    case extreme = "위험"
    
    var color: Color {
        switch self {
        case .low: return Color.gray
        case .moderate: return Color.yellow
        case .high: return Color.yellow
        case .veryHigh: return Color.red
        case .extreme: return Color.red
        }
    }
}

enum OutingMode {
    case home
    case outing
}

/*
import Foundation

// 앱 내부에서 사용하는 모델
struct WeatherInfo {
    var location: String
    var temperature: Int
    var condition: String
    var uvIndex: Int
    var uvLevel: UVLevel

    // DTO → Domain 변환
    static func from(_ dto: WeatherResponseDTO) -> WeatherInfo {
        return WeatherInfo(
            location: dto.location,
            temperature: dto.temperature,
            condition: dto.condition,
            uvIndex: dto.uvIndex,
            uvLevel: UVLevel.from(dto.uvLevel)
        )
    }

    // 빈 기본값 (로딩 전)
    static var placeholder: WeatherInfo {
        WeatherInfo(
            location: "위치 확인 중",
            temperature: 0,
            condition: "--",
            uvIndex: 0,
            uvLevel: .low
        )
    }
}

enum UVLevel: String {
    case low = "낮음"
    case moderate = "보통"
    case high = "높음"
    case veryHigh = "매우 높음"
    case extreme = "위험"

    // 문자열 → enum 변환
    static func from(_ string: String) -> UVLevel {
        return UVLevel(rawValue: string) ?? .low
    }

    var color: Color {
        switch self {
        case .low:      return Color(hex: "4CAF50")
        case .moderate: return Color(hex: "FFC107")
        case .high:     return Color(hex: "FF9800")
        case .veryHigh: return Color(hex: "F44336")
        case .extreme:  return Color(hex: "9C27B0")
        }
    }
}
*/
