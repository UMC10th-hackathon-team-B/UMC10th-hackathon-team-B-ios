import SwiftUI

struct ContentView: View {
    @StateObject var router = AppRouter()
    @State private var alertCount: Int = 0
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
                AgreementView(
                    onConfirm: {
                        router.goToHome()
                    }
                )

            // 홈 모드
            case .home:
                HomeView(
                    onOutingStart: {
                        router.goToUVSelection()
                    },
                    onAlertTap: {
                        router.showAlert = true
                    }
                )
                .sheet(isPresented: $router.showAlert) {
                    AlertView(alertCount: $alertCount)
                }
            
            //외출 시작
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
                        router.goToHome()
                    },
                    onAlertTap: {
                        router.showAlert = true
                    }
                )
                .sheet(isPresented: $router.showAlert) {
                    AlertView(alertCount: $alertCount)
                }
            }
        }
        .environmentObject(router)
        .animation(.easeInOut(duration: 0.3), value: router.currentScreen)
    }
}

#Preview {
    ContentView()
}
