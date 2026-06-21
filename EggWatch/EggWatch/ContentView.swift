import SwiftUI

struct ContentView: View {
    @StateObject var router: AppRouter
    @StateObject private var locationService: LocationService    // 앱 전역에서 공유할 위치 서비스
    @StateObject private var outingViewModel: OutingViewModel
    let onLogout: () -> Void    // EggWatchApp에서 받은 로그아웃 클로저

    init(initialScreen: AppScreen = .home, onLogout: @escaping () -> Void = {}) {
        let loc = LocationService()
        self._locationService = StateObject(wrappedValue: loc)
        self._outingViewModel = StateObject(wrappedValue: OutingViewModel(locationService: loc))
        self._router = StateObject(wrappedValue: AppRouter(initialScreen: initialScreen))
        self.onLogout = onLogout    // 외부에서 주입된 로그아웃 클로저 저장
    }

    var body: some View {
        Group {
            switch router.currentScreen {

            // 약관 동의
            case .agreement:
                AgreementView(signupToken: nil, onConfirm: { router.goToHome() })

            // 홈 모드
            case .home:
                HomeView(
                    onOutingStart: { router.goToUVSelection() },
                    onAlertTap: { router.goToAlert() },
                    onLogout: onLogout      // 로그아웃 클로저 전달
                )

            // 외출 시작
            case .uvSelection:
                UVSelectionView(
                    onBack: {
                        router.goToHome()
                    }, onOutingStart: { option in
                        outingViewModel.startOuting(sunscreenAppliedOption: option)
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
                    },
                    viewModel: outingViewModel
                )

            // 외출 종료 확인
            case .outingEndConfirm:
                OutingEndConfirmView(
                    onConfirm: {
                        outingViewModel.endOuting()
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
        .onChange(of: outingViewModel.shouldNavigateToHome) { _, newValue in
            if newValue {
                if !outingViewModel.showAutoEndPopup {
                    router.goToHome()
                    outingViewModel.shouldNavigateToHome = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
