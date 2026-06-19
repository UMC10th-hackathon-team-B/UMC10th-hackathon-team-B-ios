import SwiftUI
import KakaoSDKUser // 카카오 사용자 로그인 API
import KakaoSDKAuth // 카카오 인증(토큰) API

struct LoginView: View {
    @Binding var isLoggedIn: Bool   // App에서 넘겨받은 로그인 상태값
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
        .padding(.horizontal, 61)
        .padding(.bottom, 80)
    }
    private func kakaoLogin() { // 로그인 결과를 처리하는 클로저 (성공/실패 공통으로 사용)
        let completion: (OAuthToken?, Error?) -> Void = { oauthToken, error in
            if let error = error { print("카카오 로그인 실패: \(error)"); return }  // 실패시 종료
            guard let accessToken = oauthToken?.accessToken else { return } // 액세스 토큰 추출 (없으면 종료)
            DispatchQueue.main.async { isLoggedIn = true }
        }   // 메인 스레드에서 로그인 상태 true로 변경
        if UserApi.isKakaoTalkLoginAvailable() {    // 카카오톡 앱이 설치되어 있으면
            UserApi.shared.loginWithKakaoTalk(completion: completion)   // 카카오톡 앱으로 로그인
        } else {
            UserApi.shared.loginWithKakaoAccount(completion: completion)    // 앱 없으면 웹으로 로그인
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}
