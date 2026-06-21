//
//  AppLaunchRouter.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//
// 앱 재실행 시 화면 분기를 결정하는 API 라우터

import Foundation
import Moya
import Alamofire

// MARK: - 앱 실행 엔드포인트
enum AppLaunchRouter {
    case launch(latitude: Double, longitude: Double)  // 앱 실행 시 현재 위치 전송
}

// MARK: - Moya TargetType 설정
extension AppLaunchRouter: TargetType {

    var baseURL: URL {
        URL(string: "https://api.warnning-egg.r-e.kr/")!  // 공통 베이스 URL
    }

    var path: String {
        return "api/v1/app-launches"  // 앱 실행 API 경로
    }

    var method: Moya.Method {
        return .post  // POST 방식
    }

    var task: Task {
        switch self {
        case .launch(let latitude, let longitude):
            return .requestJSONEncodable(AppLaunchRequest(latitude: latitude, longitude: longitude))  // 위치 정보 전송
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]  // JSON 형식으로 전송
    }
}
