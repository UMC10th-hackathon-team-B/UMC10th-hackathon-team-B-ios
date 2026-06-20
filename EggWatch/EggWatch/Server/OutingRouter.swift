//
//  OutingRouter.swift
//  EggWatch
//
//  Created by 최윤석 on 6/20/26.
//

import Foundation
import Moya
import Alamofire

// MARK: - 외출 모드 엔드포인트 종류
enum OutingRouter {
    case start(SunscreenAppliedOption, Double, Double)          // 외출 시작 (3.7)
    case getCurrent(Double, Double)                              // 외출 화면 조회/새로고침 (3.8)
    case applySunscreen(Double, Double)                          // 선크림 다시 바르기 기록 (3.9)
    case end(outingSessionId: Int, latitude: Double, longitude: Double) // 외출 직접 종료 (3.10)
}

// MARK: - Moya TargetType 설정
extension OutingRouter: TargetType {

    // MARK: - 기본 URL
    var baseURL: URL {
        URL(string: "https://api.warnning-egg.r-e.kr/")!
    }

    // MARK: - 엔드포인트 경로
    var path: String {
        switch self {
        case .start:
            return "api/v1/outing-sessions"
        case .getCurrent:
            return "api/v1/outing-sessions/current"
        case .applySunscreen:
            return "api/v1/outing-sessions/current/sunscreen-applications"
        case .end(let outingSessionId, _, _):
            return "api/v1/outing-sessions/\(outingSessionId)"
        }
    }

    // MARK: - HTTP 메서드
    var method: Moya.Method {
        switch self {
        case .start:           return .post
        case .getCurrent:      return .get
        case .applySunscreen:  return .post
        case .end:             return .patch
        }
    }

    // MARK: - 요청 body / query
    var task: Task {
        switch self {
        case .start(let sunscreenAppliedOption, let latitude, let longitude):
            return .requestJSONEncodable(OutingStartRequest(
                sunscreenAppliedOption: sunscreenAppliedOption,
                latitude: latitude,
                longitude: longitude
            ))

        case .getCurrent(let latitude, let longitude):
            return .requestParameters(
                parameters: ["latitude": latitude, "longitude": longitude],
                encoding: URLEncoding.queryString
            )

        case .applySunscreen(let latitude, let longitude):
            return .requestJSONEncodable(SunscreenApplicationRequest(
                latitude: latitude,
                longitude: longitude
            ))

        case .end(_, let latitude, let longitude):
            return .requestJSONEncodable(OutingEndRequest(
                status: .completed,
                latitude: latitude,
                longitude: longitude
            ))
        }
    }

    // MARK: - 요청 헤더
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
