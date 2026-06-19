//
//  EggWatchApp.swift
//  EggWatch
//
//  Created by JOON on 6/16/26.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct EggWatchApp: App {
    @State private var isLoggedIn = false   // 로그인 상태 (false: 로그인화면, true: 홈화면)
    @State private var initialScreen: AppScreen = .home  // 로그인 후 이동할 화면

    init() {
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey)

        // 자동 로그인: Keychain에 토큰 있으면 바로 홈화면
        let hasToken = KeychainService.load(key: KeychainService.Keys.accessToken) != nil
        _isLoggedIn = State(initialValue: hasToken)
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if isLoggedIn {
                    ContentView(initialScreen: initialScreen, onLogout: {
                        KeychainService.delete(key: KeychainService.Keys.accessToken)   // 액세스 토큰 삭제
                        KeychainService.delete(key: KeychainService.Keys.refreshToken)  // 리프레시 토큰 삭제
                        isLoggedIn = false      // 로그인 화면으로 이동
                    })
                } else {
                    LoginView(isLoggedIn: $isLoggedIn, initialScreen: $initialScreen)   // 로그인 상태와 이동할 화면을 LoginView와 공유
                }
            }
            .onOpenURL { url in // 카카오톡 앱으로 로그인하고 다시 EggWatch로 돌아올 때 실행되는 코드
                if AuthApi.isKakaoTalkLoginUrl(url) {   // 돌아온 URL이 카카오 로그인용 URL인지 확인
                    _ = AuthController.handleOpenUrl(url: url)  // 맞으면 카카오 SDK한테 URL 넘겨줘서 로그인 완료 처리
                }
            }
        }
    }
}
