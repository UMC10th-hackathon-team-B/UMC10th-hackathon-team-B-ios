import SwiftUI

struct HomeView: View {
    let onOutingStart: () -> Void
    let onAlertTap: () -> Void

    //ViewModel 연결 (추후 HomeViewModel로 분리)
    @State private var weather = WeatherInfo()
    @State private var exposureLevel: Double = 0.0
    @State private var alertCount: Int = 2
    @State private var showAlert: Bool = false
    @State private var showLogout: Bool = false

    var statusMessage: String {
        switch exposureLevel {
        case 0..<0.2: return "안전한 계란이에요."
        case 0.2..<0.5: return "조금 그을리고 있어요."
        case 0.5..<0.8: return "선크림을 발라주세요!"
        default: return "많이 탔어요! 실내로 이동하세요."
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            EggWatchNavigationBar(
                mode: .home,
                alertCount: alertCount,
                onAlertTap: {
                    onAlertTap()
                },
                onLogoutTap: {
                    showLogout = true
                }
            )
            VStack(spacing: 0) {
                WeatherInfoCard(weather: weather)
                    .padding(.bottom, 70)
                EggCharacterView(
                    exposureLevel: exposureLevel,
                    statusMessage: statusMessage
                )
            }
            .padding(.horizontal, 43)
            Spacer()
            homeActionButtons
        }
        .sheet(isPresented: $showAlert) {
            //AlertView 연결
        }
        .overlay {
            if showLogout {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture { showLogout = false }
                LogoutView(isPresented: $showLogout) {
                    // TODO: 로그아웃 로직 연결
                }
            }
        }
    }

    // MARK: - 하단 버튼
    private var homeActionButtons: some View {
        HStack(spacing: 0) {
            Button(action: onOutingStart) {
                Text("외출 시작")
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
        }
        .padding(.horizontal, 61)
        .padding(.bottom, 80)
    }
}

#Preview {
    HomeView(
        onOutingStart: { }, onAlertTap: { }
    )
}
