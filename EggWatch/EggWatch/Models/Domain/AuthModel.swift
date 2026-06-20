//
//  AuthModel.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//
// 백엔드와 주고 받는 데이터의 형식을 정의하는 파일
import Foundation

// MARK: - 카카오 로그인 요청
struct AuthRequest: Encodable { // 백엔드에 보낼 데이터 형식, Encodable 은 Swift 데이터를 JSON으로 변환할 수 있게 해주는 프로토콜 - 백엔드에 데이터를 보낼 때 쓰임.
    let kakaoAccessToken: String    // 카카오에서 받은 액세스 토큰
}

// MARK: - 카카오 로그인 응답
struct AuthSessionResponse: Decodable { // 백엔드에서 받을 데이터 형식
    let nextScreen: NextScreen  // 다음에 보여줄 화면 (HOME, TERMS, OUTING)
    let userId: Int?            // 유저 ID (HOME, OUTING일 때만)
    let auth: AuthTokens?       // JWT 토큰 묶음 (HOME, OUTING일 때만)
    let signupToken: String?    // 약관 동의용 임시 토큰 (TERMS일 때만)
}

// MARK: - nextScreen 종류
enum NextScreen: String, Decodable {    // 백엔드가 알려주는 다음 화면 종류
    case home = "HOME"
    case terms = "TERMS"
    case outing = "OUTING"
}

// MARK: - 토큰 재발급 요청
struct TokenRefreshRequest: Encodable {
    let refreshToken: String    // 재발급에 사용할 리프레시 토큰
}

// MARK: - 로그아웃 요청
struct LogoutRequest: Encodable {
    let refreshToken: String    // 로그아웃할 세션의 리프레시 토큰
}

// MARK: - 약관 동의 요청
struct UserRequest: Encodable {
    let signupToken: String
    let agreedTermTypes: [String]
}

// MARK: - 약관 동의 응답
struct UserResponse: Decodable {
    let nextScreen: NextScreen
    let userId: Int
    let auth: AuthTokens
}

// MARK: - JWT 토큰 정보
struct AuthTokens: Decodable {
    let tokenType: String
    let accessToken: String
    let accessTokenExpiresInSeconds: Int
    let refreshToken: String
    let refreshTokenExpiresAt: String
}

// MARK: - 공통 응답 래퍼
struct APIResponse<T: Decodable>: Decodable {
    let success: Bool   // 요청 성공 여부
    let code: String    // 응답 코드 (COMMON_200, AUTH_401 등)
    let message: String // 응답 메시지
    let data: T?        // 실제 응답 데이터 (실패 시 null)
}

// MARK: - API 에러 코드
enum APIError: String {
    // 공통
    case common400 = "COMMON_400"   // 잘못된 요청
    // 인증
    case auth400 = "AUTH_400"       // 카카오 토큰 검증 실패
    case auth401 = "AUTH_401"       // 토큰 만료 또는 없음
    // 사용자
    case user404 = "USER_404"       // 사용자 없음
    // 약관
    case terms400 = "TERMS_400"     // 필수 약관 누락
    // 날씨
    case weather502 = "WEATHER_502" // 날씨 외부 API 실패
    // 외출
    case outing400 = "OUTING_400"   // 외출 시작 불가
    case outing404 = "OUTING_404"   // 진행 중인 외출 없음
    case outing409 = "OUTING_409"   // 이미 외출 중
    // 알림
    case notification404 = "NOTIFICATION_404" // 알림 없음
}
