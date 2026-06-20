//
//  AppLaunchService.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//
// 앱 재실행 시 서버에 현재 위치를 보내고 이동할 화면을 결정하는 서비스

import Foundation
import Moya

// MARK: - 앱 실행 서비스
class AppLaunchService {

    private let provider = MoyaProvider<AppLaunchRouter>(plugins: [
        AuthPlugin(),        // accessToken 헤더 자동 첨부
        TokenRefreshPlugin() // 401 시 자동 재발급
    ])

    // MARK: - 앱 실행 API 호출
    func launch(latitude: Double, longitude: Double, completion: @escaping (Result<AppLaunchResponse, Error>) -> Void) {
        provider.request(.launch(latitude: latitude, longitude: longitude)) { result in
            switch result {
            case .success(let response):
                guard let wrapped = try? response.map(APIResponse<AppLaunchResponse>.self),
                      let data = wrapped.data else {
                    completion(.failure(NSError(domain: "AppLaunch", code: -1))) // 파싱 실패
                    return
                }
                completion(.success(data))  // 성공 시 응답 데이터 전달
            case .failure(let error):
                completion(.failure(error)) // 실패 시 에러 전달
            }
        }
    }
}
