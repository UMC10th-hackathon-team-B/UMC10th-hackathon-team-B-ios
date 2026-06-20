//
//  LoginView.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//

import SwiftUI
import KakaoSDKUser // 카카오 사용자 로그인 API
import KakaoSDKAuth // 카카오 인증(토큰) API
import Moya

// fullScreenCover에 토큰을 안전하게 전달하기 위한 래퍼
struct SignupTokenItem: Identifiable {
    let id = UUID()
    let token: String
}

struct LoginView: View {
    @Binding var isLoggedIn: Bool   // App에서 넘겨받은 로그인 상태값
    @Binding var initialScreen: AppScreen       // 로그인 후 이동할 화면
    @State private var signupItem: SignupTokenItem? = nil  // 약관 동의 시 토큰을 담아 전달
    
    private let provider = MoyaProvider<AuthRouter>()   // Moya API 호출 객체
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            eggImage
            titleGroup
                .padding(.top, 20)
            Spacer()
            kakaoButton
        }
        .background(Color(.systemBackground))
        .fullScreenCover(item: $signupItem) { item in  // item에서 토큰을 직접 꺼내서 전달
            AgreementView(signupToken: item.token, onConfirm: {
                isLoggedIn = true
                signupItem = nil  // 커버 닫힌 후 초기화
            })
        }
    }
    
    //MARK: - 계란 이미지
    private var eggImage: some View {
        Image("egg1")
            .resizable()    //이미지 크기 바꿔도 된다고 허락하는 거
            .scaledToFit()  //이미지 비율 유지
            .frame(width: 160, height: 216)
    }
    
    //MARK: - 타이틀 / 서브타이틀
    private var titleGroup: some View {
        VStack(spacing: 6) {
            Text("계란 주의보")
                .font(.semiBold20)
                .foregroundStyle(Color.black)
            Text("오늘도 계란이를 지켜볼까요?")
                .font(.regular14)
                .foregroundStyle(Color.black)
        }
    }
    
    //MARK: - 카카오 로그인 버튼
    private var kakaoButton: some View {
        Button {
            kakaoLogin()
        } label: {
                Image("kakao")
                    .resizable()
                    .scaledToFit()
        }
        .glassEffect(
            .regular
                .tint(Color.yellow01.opacity(0.6))
                .interactive(),
            in: .capsule
        )
        .padding(.horizontal, 41)
        .padding(.bottom, 80)
    }
    
    // MARK: - 카카오 로그인
    private func kakaoLogin() { // 로그인 결과를 처리하는 클로저 (성공/실패 공통으로 사용)
        let completion: (OAuthToken?, Error?) -> Void = { oauthToken, error in
            if let error = error { print("카카오 로그인 실패: \(error)"); return }  // 실패시 종료
            guard let accessToken = oauthToken?.accessToken else { return } // 액세스 토큰 추출 (없으면 종료)
            sendToServer(kakaoAccessToken: accessToken) // 카카오 액세스 토큰을 백엔드로 전송
        }
        if UserApi.isKakaoTalkLoginAvailable() {    // 카카오톡 앱이 설치되어 있으면
            UserApi.shared.loginWithKakaoTalk(completion: completion)   // 카카오톡 앱으로 로그인
        } else {
            UserApi.shared.loginWithKakaoAccount(completion: completion)    // 앱 없으면 웹으로 로그인
        }
    }
    // MARK: - 백엔드에 카카오 액세스 토큰 전송
    private func sendToServer(kakaoAccessToken: String) {
        provider.request(.login(kakaoAccessToken: kakaoAccessToken)) { result in
            switch result {
            case .success(let response):
                guard let wrappedResponse = try? response.map(APIResponse<AuthSessionResponse>.self),
                      let data = wrappedResponse.data else {
                    print("❌ 로그인 API 파싱 실패 - 상태코드: \(response.statusCode)")
                    return
                }
                print("✅ 로그인 API 성공 - 다음 화면: \(data.nextScreen)")
                DispatchQueue.main.async { handleNextScreen(data) }
            case .failure(let error):
                print("❌ 로그인 API 실패 - \(error)")
            }
        }
    }

    // MARK: - nextScreen에 따라 화면 분기
    private func handleNextScreen(_ response: AuthSessionResponse) {
        switch response.nextScreen {
        case .home:
            saveTokens(accessToken: response.auth?.accessToken, refreshToken: response.auth?.refreshToken)  // auth 안에서 토큰 꺼내서 저장
            isLoggedIn = true   // 홈화면으로 이동
        case .outing:
            saveTokens(accessToken: response.auth?.accessToken, refreshToken: response.auth?.refreshToken)  // auth 안에서 토큰 꺼내서 저장
            initialScreen = .outing // 외출모드로 이동할 화면 설정
            isLoggedIn = true   // 외출모드 화면으로 이동
        case .terms:
            signupItem = SignupTokenItem(token: response.signupToken ?? "")  // 토큰을 item으로 감싸서 커버 띄움
        }
    }

    // MARK: - JWT Keychain 저장
    private func saveTokens(accessToken: String?, refreshToken: String?) {
        if let accessToken { KeychainService.save(key: KeychainService.Keys.accessToken, value: accessToken) }
        if let refreshToken { KeychainService.save(key: KeychainService.Keys.refreshToken, value: refreshToken) }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false), initialScreen: .constant(.home))
}
