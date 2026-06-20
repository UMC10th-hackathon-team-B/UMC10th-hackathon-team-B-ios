import SwiftUI

struct OutingView: View {
    @EnvironmentObject private var router: AppRouter
    @ObservedObject var viewModel: OutingViewModel

    let onOutingEnd: () -> Void
    let onAlertTap: () -> Void

    @State private var showLogout: Bool = false
    @State private var outingElapsedSeconds: Int = 0

    init(onOutingEnd: @escaping () -> Void,
         onAlertTap: @escaping () -> Void,
         viewModel: OutingViewModel) {
        self.onOutingEnd = onOutingEnd
        self.onAlertTap = onAlertTap
        self.viewModel = viewModel
    }

    // MARK: - 화면 표시용 변환 (명세서 모델 → 기존 UI 컴포넌트 모델)

    // OutingWeatherInfo → 임시 WeatherInfo (A 영역 통합 시 정리 예정)
    private var displayWeather: WeatherInfo {
        guard let w = viewModel.outingContext?.weather else { return WeatherInfo() }
        return WeatherInfo(
            location: w.locationName,
            temperature: Int(w.temperatureCelsius),
            condition: w.weatherLabel,
            uvIndex: Int(w.uvIndex),
            uvLevel: mapUVLevel(w.uvLevel)
        )
    }

    // EggStatus → 노출도(0.0~1.0) 변환 — EggCharacterView 시각 단계용
    private var exposureLevel: Double {
        guard let status = viewModel.outingContext?.egg.eggStatus else { return 0.0 }
        switch status {
        case .safe:         return 0.1
        case .lightToasted: return 0.3
        case .toasted:      return 0.5
        case .burned:       return 0.7
        case .danger:       return 0.9
        }
    }

    private var statusMessage: String {
        viewModel.outingContext?.egg.message ?? ""
    }

    private var alertCount: Int {
        viewModel.outingContext?.notification.unreadCount ?? 0
    }

    private var lastRecordTime: String {
        viewModel.outingContext?.sunscreen.lastSunscreenAppliedAt ?? "--"
    }

    private var lastRecordAgo: String {
        viewModel.outingContext?.sunscreen.lastSunscreenAppliedText ?? "기록 없음"
    }

    // APIUVLevel → 임시 UVLevel 매핑 (A 영역 통합 전 임시 변환)
    private func mapUVLevel(_ level: APIUVLevel) -> UVLevel {
        switch level {
        case .low:      return .low
        case .normal:   return .moderate
        case .high:     return .high
        case .veryHigh: return .veryHigh
        case .danger:   return .extreme
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            EggWatchNavigationBar(
                mode: .outing,
                alertCount: alertCount,
                onAlertTap: {
                    onAlertTap()
                },
                onRefreshTap: {
                    viewModel.fetchCurrent()         // 새로고침 시 외출 화면 재조회
                },
                onLogoutTap: {
                    showLogout = true
                }
            )
            VStack(spacing: 0) {
                WeatherInfoCard(weather: displayWeather, outingElapsedSeconds: outingElapsedSeconds)
                    .padding(.bottom, 70)
                EggCharacterView(
                    exposureLevel: exposureLevel,
                    statusMessage: statusMessage
                )
            }
            .padding(.horizontal, 22)
            Spacer()
            outingActionButtons
        }
        .onAppear {
            if viewModel.outingContext == nil && !viewModel.isLoading {
                viewModel.fetchCurrent()                 // 화면 진입 시 외출 데이터 로딩
            }
        }
        .task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(1))
                outingElapsedSeconds += 1
            }
        }
        .sheet(isPresented: $viewModel.showSunscreenConfirm) {
            SuncreamConfirmView(
                onConfirm: {
                    viewModel.applySunscreen()
                },
                onCancel: {
                    viewModel.showSunscreenConfirm = false
                }
            )
        }
        .alert("로그아웃", isPresented: $showLogout) {
            Button("취소", role: .cancel) { }
            Button("로그아웃", role: roleLogout) {
                // TODO: 로그아웃 로직 연결
            }
        } message: {
            Text("정말 로그아웃할까요?")
        }
        .overlay {
            if viewModel.showAutoEndPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                UVTimeoutPopupView {
                    viewModel.showAutoEndPopup = false
                    viewModel.shouldNavigateToHome = false
                    router.goToHome()
                }
            }
            if viewModel.showUVNotAvailablePopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                UVNotAvailablePopupView {
                    viewModel.showUVNotAvailablePopup = false
                    router.goToHome()
                }
            }
        }
    }

    private var roleLogout: ButtonRole? {
        .destructive
    }

    // MARK: - 하단 버튼
    private var outingActionButtons: some View {
        VStack(spacing: 10) {
            HStack(spacing: 0) {
                Text("마지막 기록: \(lastRecordTime) ")
                    .font(.regular9)
                    .foregroundStyle(.gray02)
                Text("(\(lastRecordAgo))")
                    .font(.regular9)
                    .foregroundStyle(.gray02)
            }
            .underline()
            HStack(spacing: 12) {
                Button(action: onOutingEnd) {
                    Text("외출 종료")
                        .font(.semiBold16)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .glassEffect(
                            .regular
                                .tint(Color.yellow01.opacity(0.6))
                                .interactive(),
                            in: .capsule
                        )
                }
                Button(action: {
                    viewModel.showSunscreenConfirm = true
                }) {
                    Text("자외선 차단제 기록")
                        .font(.semiBold16)
                        .foregroundStyle(.black)
                        .frame(width: 164, height: 48)
                        .glassEffect(
                            .regular
                                .tint(Color.white.opacity(0.6))
                                .interactive(),
                            in: .capsule
                        )
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(.horizontal, 34)
        .padding(.bottom, 80)
    }
}

#Preview {
    OutingView(
        onOutingEnd: { }, onAlertTap: { }, viewModel: OutingViewModel(locationService: LocationService())
    )
}
