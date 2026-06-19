//
//  AuthModel.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//
// 백엔드와 주고 받는 데이터의 형식을 정의하는 파일
import Foundation

// MARK: 카카오 로그인 요청
struct AuthRequest: Encodable { // 백엔드에 보낼 데이터 형식, Encodable 은 Swift 데이터를 JSON으로 변환할 수 있게 해주는 프로토콜 - 백엔드에 데이터를 보낼 때 쓰임.
    let kakaoAccessToken: String    // 카카오에서 받은 액세스 토큰
}

// MARK: 카카오 로그인 응답
struct AuthSessionResponse: Decodable { // 백엔드에서 받을 데이터 형식
    let nextScreen: NextScreen  // 다음에 보여줄 화면 (HOME, TERMS, OUTING)
    let userId: Int?            // 유저 ID (HOME, OUTING일 때만)
    let auth: AuthTokens?       // JWT 토큰 묶음 (HOME, OUTING일 때만)
    let signupToken: String?    // 약관 동의용 임시 토큰 (TERMS일 때만)
}

// MARK: nextScreen 종류
enum NextScreen: String, Decodable {    // 백엔드가 알려주는 다음 화면 종류
    case home = "HOME"
    case terms = "TERMS"
    case outing = "OUTING"
}

// MARK: 약관 동의 요청
struct UserRequest: Encodable {
    let signupToken: String
    let agreedTermTypes: [String]
}

// MARK: 약관 동의 응답
struct UserResponse: Decodable {
    let nextScreen: NextScreen
    let userId: Int
    let auth: AuthTokens
}

// MARK: JWT 토큰 정보
struct AuthTokens: Decodable {
    let tokenType: String
    let accessToken: String
    let accessTokenExpiresInSeconds: Int
    let refreshToken: String
    let refreshTokenExpiresAt: String
}

// MARK: 공통 응답 래퍼 (백엔드가 data 안에 응답을 감싸서 보냄)
struct APIResponse<T: Decodable>: Decodable {
    let success: Bool   // 요청 성공 여부
    let data: T         // 실제 응답 데이터
}
