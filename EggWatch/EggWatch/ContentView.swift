import SwiftUI

struct ContentView: View {
    @StateObject var router: AppRouter

    init(initialScreen: AppScreen = .home) {
        _router = StateObject(wrappedValue: AppRouter(initialScreen: initialScreen))
    }

    var body: some View {
        Group {
            switch router.currentScreen {

            // 스플래시
            case .splash:
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            router.goToAgreement()
                        }
                    }

            // 약관 동의
            case .agreement:
                AgreementView(signupToken: nil, onConfirm: { router.goToHome() })

            // 홈 모드
            case .home:
                HomeView(
                    onOutingStart: {
                        router.goToUVSelection()
                    },
                    onAlertTap: {
                        router.goToAlert()
                    }
                )

            // 외출 시작
            case .uvSelection:
                UVSelectionView(
                    onBack: {
                        router.goToHome()
                    }, onOutingStart: {
                        router.goToOuting()
                    }
                )

            // 외출 모드
            case .outing:
                OutingView(
                    onOutingEnd: {
                        router.goToOutingEndConfirm()
                    },
                    onAlertTap: {
                        router.goToAlert()
                    }
                )

            // 외출 종료 확인
            case .outingEndConfirm:
                OutingEndConfirmView(
                    onConfirm: {
                        router.goToHome()
                    },
                    onCancel: {
                        router.goToOuting()
                    }
                )

            // 알림
            case .alert:
                AlertView(
                    onBack: {
                        router.goBack()
                    }
                )
            }
        }
        .environmentObject(router)
        .animation(.easeInOut(duration: 0.3), value: router.currentScreen)
    }
}

#Preview {
    ContentView()
}
