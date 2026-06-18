import SwiftUI

struct OutingView: View {
    let onOutingEnd: () -> Void
    let onAlertTap: () -> Void

    @State private var weather = WeatherInfo()
    @State private var exposureLevel: Double = 0.0
    @State private var alertCount: Int = 2
    @State private var showAlert: Bool = false
    @State private var showLogout: Bool = false
    @State private var showSuncreamConfirm: Bool = false
    @State private var lastRecordTime: String = "3시 33분"
    @State private var lastRecordAgo: String = "1시간 전"

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
                mode: .outing,
                alertCount: alertCount,
                onAlertTap: {
                    onAlertTap()
                },
                onRefreshTap: {
                    /* 날씨 새로고침 */
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
            outingActionButtons
        }
        .sheet(isPresented: $showAlert) {
            //AlertView 연결
        }
        .sheet(isPresented: $showSuncreamConfirm) {
            SuncreamConfirmView(
                onConfirm: {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        exposureLevel = max(0.0, exposureLevel - 0.3)
                        lastRecordTime = currentTimeString()
                        lastRecordAgo = "방금 전"
                    }
                    showSuncreamConfirm = false
                },
                onCancel: {
                    showSuncreamConfirm = false
                }
            )
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
                    showSuncreamConfirm = true
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
        }
        .padding(.horizontal, 33)
        .padding(.bottom, 80)
    }

    private func currentTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H시 mm 분"
        return formatter.string(from: Date())
    }
}

#Preview {
    OutingView(
        onOutingEnd: { }, onAlertTap: { }
    )
}
