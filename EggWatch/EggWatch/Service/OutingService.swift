//
//  OutingService.swift
//  EggWatch
//
//  Created by 최윤석 on 6/20/26.
//
//  외출 도메인 API 4개(시작/조회/선크림/종료)를 호출하는 서비스

import Foundation
import Moya

// MARK: - 외출 서비스
class OutingService {

    // MARK: - Moya Provider
    // AuthPlugin: accessToken 헤더 자동 첨부
    // TokenRefreshPlugin: 401 시 자동 재발급
    // NetworkLoggerPlugin: 상세 요청/응답 로그
    private let provider = MoyaProvider<OutingRouter>(plugins: [
        AuthPlugin(),
        TokenRefreshPlugin(),
        NetworkLoggerPlugin()
    ])

    // MARK: - 외출 시작 API 호출 (3.7)
    func startOuting(sunscreenAppliedOption: SunscreenAppliedOption,
                     latitude: Double,
                     longitude: Double,
                     completion: @escaping (Result<OutingResponse, Error>) -> Void) {
        provider.request(.start(sunscreenAppliedOption, latitude, longitude)) { result in
            switch result {
            case .success(let response):
                guard let wrapped = try? response.map(APIResponse<OutingResponse>.self),
                      let data = wrapped.data else {
                    completion(.failure(NSError(domain: "Outing", code: -1))) // 파싱 실패
                    return
                }
                completion(.success(data))  // 성공 시 외출 응답 데이터 전달
            case .failure(let error):
                completion(.failure(error)) // 실패 시 에러 전달
            }
        }
    }

    // MARK: - 외출 화면 조회/새로고침 API 호출 (3.8)
    // 자동 종료 시간 경과 시 endedSession 필드가 포함된 응답을 반환 (1.6)
    func fetchCurrent(latitude: Double,
                      longitude: Double,
                      completion: @escaping (Result<OutingResponse, Error>) -> Void) {
        provider.request(.getCurrent(latitude, longitude)) { result in
            switch result {
            case .success(let response):
                guard let wrapped = try? response.map(APIResponse<OutingResponse>.self),
                      let data = wrapped.data else {
                    completion(.failure(NSError(domain: "Outing", code: -1))) // 파싱 실패
                    return
                }
                completion(.success(data))  // 성공 시 외출 응답 데이터 전달
            case .failure(let error):
                completion(.failure(error)) // 실패 시 에러 전달
            }
        }
    }

    // MARK: - 자외선 차단제 다시 바르기 기록 API 호출 (3.9)
    // 자동 종료 시간 경과 시 기록은 저장되지 않고 endedSession 응답을 반환 (1.6)
    func applySunscreen(latitude: Double,
                        longitude: Double,
                        completion: @escaping (Result<OutingResponse, Error>) -> Void) {
        provider.request(.applySunscreen(latitude, longitude)) { result in
            switch result {
            case .success(let response):
                guard let wrapped = try? response.map(APIResponse<OutingResponse>.self),
                      let data = wrapped.data else {
                    completion(.failure(NSError(domain: "Outing", code: -1))) // 파싱 실패
                    return
                }
                completion(.success(data))  // 성공 시 외출 응답 데이터 전달
            case .failure(let error):
                completion(.failure(error)) // 실패 시 에러 전달
            }
        }
    }

    // MARK: - 외출 세션 직접 종료 API 호출 (3.10)
    // 자동 종료 시간 경과 시 수동 종료는 수행되지 않고 AUTO 사유로 종료됨 (1.6)
    func endOuting(outingSessionId: Int,
                   latitude: Double,
                   longitude: Double,
                   completion: @escaping (Result<OutingEndResponse, Error>) -> Void) {
        provider.request(.end(outingSessionId: outingSessionId, latitude: latitude, longitude: longitude)) { result in
            switch result {
            case .success(let response):
                guard let wrapped = try? response.map(APIResponse<OutingEndResponse>.self),
                      let data = wrapped.data else {
                    completion(.failure(NSError(domain: "Outing", code: -1))) // 파싱 실패
                    return
                }
                completion(.success(data))  // 성공 시 종료된 세션 정보 전달
            case .failure(let error):
                completion(.failure(error)) // 실패 시 에러 전달
            }
        }
    }
}
