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
