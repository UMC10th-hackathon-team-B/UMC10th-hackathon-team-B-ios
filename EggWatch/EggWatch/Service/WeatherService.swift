/*import Foundation
import Alamofire

class WeatherService {
    // 백엔드 주소 (받으면 여기 수정)
    private let baseURL = "https://백엔드주소/api"

    // 날씨 정보 요청
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherInfo {
        let url = "\(baseURL)/weather"
        let params: [String: Double] = [
            "lat": lat,
            "lon": lon
        ]

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, parameters: params)
                .validate()
                .responseDecodable(of: WeatherResponseDTO.self) { response in
                    switch response.result {
                    case .success(let dto):
                        // DTO → Domain 변환
                        continuation.resume(returning: WeatherInfo.from(dto))
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
*/
