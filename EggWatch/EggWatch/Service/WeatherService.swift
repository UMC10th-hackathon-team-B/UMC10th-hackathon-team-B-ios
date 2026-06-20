//
//  WeatherService.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//
// 홈 화면 날씨/자외선 데이터를 서버에서 가져오는 서비스

import Foundation
import Moya

// MARK: - 날씨 서비스
class WeatherService {

    private let provider = MoyaProvider<WeatherRouter>(plugins: [
        AuthPlugin(),        // accessToken 헤더 자동 첨부
        TokenRefreshPlugin() // 401 시 자동 재발급
    ])

    // MARK: - 날씨 조회 API 호출
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherObservationResponse, Error>) -> Void) {
        provider.request(.fetchWeather(latitude: latitude, longitude: longitude)) { result in
            switch result {
            case .success(let response):
                guard let wrapped = try? response.map(APIResponse<WeatherObservationResponse>.self),
                      let data = wrapped.data else {
                    print("❌ 날씨 API 파싱 실패 - 상태코드: \(response.statusCode)")
                    completion(.failure(NSError(domain: "Weather", code: -1)))
                    return
                }
                print("✅ 날씨 API 성공 - 위치: \(data.weather.locationName), 기온: \(data.weather.temperatureCelsius)°C, 자외선: \(data.weather.uvLevel)")
                completion(.success(data))
            case .failure(let error):
                print("❌ 날씨 API 실패 - \(error)")
                completion(.failure(error))
            }
        }
    }
}
