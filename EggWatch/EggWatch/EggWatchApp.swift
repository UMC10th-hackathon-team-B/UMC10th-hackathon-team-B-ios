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

    init() {
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String ?? "" // Info.plist에서 카카오 앱 키 읽기 (없으면 빈 문자열)
        KakaoSDK.initSDK(appKey: kakaoAppKey)   // 카카오 SDK 초기화
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if isLoggedIn {
                    ContentView()  // isLoggedIn이 true면 홈화면 보여주기
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)   // isLoggedIn이 false면 로그인화면 보여주기
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
