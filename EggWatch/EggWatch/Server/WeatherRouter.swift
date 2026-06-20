//
//  WeatherRouter.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//
// 홈 화면 날씨/자외선 데이터 조회 API 라우터

import Foundation
import Moya
import Alamofire

// MARK: - 날씨 엔드포인트
enum WeatherRouter {
    case fetchWeather(latitude: Double, longitude: Double)  // 날씨 조회
}

// MARK: - Moya TargetType 설정
extension WeatherRouter: TargetType {

    var baseURL: URL {
        URL(string: "https://api.warnning-egg.r-e.kr/")!  // 공통 베이스 URL
    }

    var path: String {
        return "api/v1/weather-observations"  // 날씨 조회 경로
    }

    var method: Moya.Method {
        return .get  // GET 방식
    }

    var task: Task {
        switch self {
        case .fetchWeather(let latitude, let longitude):
            return .requestParameters(
                parameters: ["latitude": latitude, "longitude": longitude],  // 위치 쿼리 파라미터로 전송
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
