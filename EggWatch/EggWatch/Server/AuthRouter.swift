//
//  AuthRouter.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//

import Foundation
import Moya
import Alamofire

// MARK: - 엔드포인트 종류
enum AuthRouter {
    case login(kakaoAccessToken: String)        // 카카오 로그인 API 호출, 카카오에서 받은 엑세스 토큰 들고 와야 함
    case register(signupToken: String)          // 약관 동의 API 호출, 카카오 로그인 때 백엔드에서 받은 signupToken 들고 와야 함
}

// MARK: - Moya TargetType 설정
extension AuthRouter: TargetType {  // Moya에게 AuthRouter가 API라우터라고 알려줌.

    // MARK: - 기본 URL
    var baseURL: URL {  // 모든 API의 공통 주소
        URL(string: "https://api.warnning-egg.r-e.kr/")!
    }

    // MARK: - 엔드포인트 경로
    var path: String {
        switch self {
        case .login:    return "api/v1/auth-sessions"
        case .register: return "api/v1/users"
        }
    }

    // MARK: - HTTP 메서드
    var method: Moya.Method {   // HTTP요청 방식. 둘 다 데이터를 보내는 POST 방식.
        switch self {
        case .login:    return .post
        case .register: return .post
        }
    }

    // MARK: - 요청 body
    var task: Task {    // 백엔드에 실제로 보낼 데이터를 담는 곳
        switch self {
        case .login(let kakaoAccessToken):
            return .requestJSONEncodable(AuthRequest(kakaoAccessToken: kakaoAccessToken))
        case .register(let signupToken):
            return .requestJSONEncodable(UserRequest(
                signupToken: signupToken,
                agreedTermTypes: ["SERVICE", "PRIVACY", "LOCATION"]
            ))
        }
    }

    // MARK: - 요청 헤더
    var headers: [String: String]? {    //JSON형식으로 보낸다고 백엔드에 알려주는 설정.
        return ["Content-Type": "application/json"]
    }
}
