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
    @State private var isLoggedIn = false                        // 로그인 상태
    @State private var initialScreen: AppScreen = .home         // 로그인 후 이동할 화면
    @StateObject private var locationService = LocationService() // 위치 서비스
    private let appLaunchService = AppLaunchService()            // 앱 실행 서비스
    private let authService = AuthService()                      // 인증 서비스 (로그아웃)

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
                        authService.logout { _ in
                            DispatchQueue.main.async {
                                KeychainService.delete(key: KeychainService.Keys.accessToken)   // 액세스 토큰 삭제
                                KeychainService.delete(key: KeychainService.Keys.refreshToken)  // 리프레시 토큰 삭제
                                isLoggedIn = false      // 로그인 화면으로 이동
                            }
                        }
                    })
                } else {
                    LoginView(isLoggedIn: $isLoggedIn, initialScreen: $initialScreen)   // 로그인 상태와 이동할 화면을 LoginView와 공유
                }
            }
            .onAppear {
                guard isLoggedIn else { return }    // 토큰 없으면 패스
                locationService.fetchOnce()         // 위치 한 번 가져오기
            }
            .onChange(of: isLoggedIn) { _, loggedIn in
                guard loggedIn else { return }
                let lat = locationService.latitude
                let lon = locationService.longitude
                if lat != 0.0 && lon != 0.0 {
                    // 이미 위치 있으면 바로 AppLaunch 호출
                    appLaunchService.launch(latitude: lat, longitude: lon) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let data):
                                initialScreen = data.nextScreen == .outing ? .outing : .home
                            case .failure(let error):
                                print("앱 실행 API 실패: \(error)")
                            }
                        }
                    }
                } else {
                    locationService.fetchOnce()     // 위치 없으면 다시 요청
                }
            }
            .onChange(of: locationService.latitude) { _, lat in
                // 위치 가져오면 앱 실행 API 호출
                let lon = locationService.longitude
                guard isLoggedIn, lat != 0.0, lon != 0.0 else { return }   // 유효한 위치인지 확인
                appLaunchService.launch(latitude: lat, longitude: lon) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            if data.nextScreen == .outing {
                                initialScreen = .outing // 외출 중이었으면 외출화면으로
                            } else {
                                initialScreen = .home   // 아니면 홈화면으로
                            }
                        case .failure(let error):
                            print("앱 실행 API 실패: \(error)")  // 실패해도 홈화면 유지
                        }
                    }
                }
            }
            .onOpenURL { url in // 카카오톡 앱으로 로그인하고 다시 EggWatch로 돌아올 때 실행되는 코드
                if AuthApi.isKakaoTalkLoginUrl(url) {   // 돌아온 URL이 카카오 로그인용 URL인지 확인
                    _ = AuthController.handleOpenUrl(url: url)  // 맞으면 카카오 SDK한테 URL 넘겨줘서 로그인 완료 처리
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .forceLogout)) { _ in
                // Refresh 토큰도 만료된 경우 로그인 화면으로 강제 이동
                isLoggedIn = false
            }
        }
    }
}
