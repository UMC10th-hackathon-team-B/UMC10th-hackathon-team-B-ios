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
                    completion(.failure(NSError(domain: "Weather", code: -1)))  // 파싱 실패
                    return
                }
                completion(.success(data))  // 성공 시 응답 데이터 전달
            case .failure(let error):
                completion(.failure(error)) // 실패 시 에러 전달
            }
        }
    }
}
