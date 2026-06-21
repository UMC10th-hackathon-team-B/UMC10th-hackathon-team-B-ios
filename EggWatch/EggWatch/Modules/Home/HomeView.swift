import SwiftUI

struct HomeView: View {
    let onOutingStart: () -> Void
    let onAlertTap: () -> Void
    let onLogout: () -> Void

    @StateObject private var viewModel = HomeViewModel()    // 날씨 뷰모델

    @State private var showAlert: Bool = false
    @State private var showLogout: Bool = false
    @State private var showUVNotAvailable: Bool = false

    private var isAfter8pm: Bool {
        Calendar.current.component(.hour, from: Date()) >= 20
    }

    // API 날씨 데이터 → WeatherInfoCard용 WeatherInfo 변환
    private var currentWeather: WeatherInfo {
        guard let w = viewModel.weather else {
            return WeatherInfo()    // 로딩 전 기본값
        }
        return WeatherInfo(
            location: w.locationName,
            temperature: Int(w.temperatureCelsius),
            condition: w.weatherLabel,
            uvIndex: Int(w.uvIndex),
            uvLevel: uvLevelFromAPI(w.uvLevel)
        )
    }

    // API 계란 상태 → 노출 수치 변환
    private var exposureLevel: Double {
        switch viewModel.egg?.eggStatus {
        case "SAFE":            return 0.0
        case "LIGHT_TOASTED":   return 0.3
        case "TOASTED":         return 0.55
        case "BURNED":          return 0.75
        case "DANGER":          return 1.0
        default:                return 0.0
        }
    }

    private var statusMessage: String {
        viewModel.egg?.message ?? "날씨 정보를 불러오는 중..."
    }

    // API UV 레벨 문자열 → UVLevel enum 변환
    private func uvLevelFromAPI(_ level: String) -> UVLevel {
        switch level {
        case "LOW":         return .low
        case "NORMAL":      return .moderate
        case "HIGH":        return .high
        case "VERY_HIGH":   return .veryHigh
        case "DANGER":      return .extreme
        default:            return .low
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            EggWatchNavigationBar(
                mode: .home,
                alertCount: viewModel.unreadCount,
                onAlertTap: {
                    onAlertTap()
                },
                onLogoutTap: {
                    showLogout = true
                }
            )
            VStack(spacing: 0) {
                WeatherInfoCard(weather: currentWeather)
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
            if showUVNotAvailable {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                UVNotAvailablePopupView {
                    showUVNotAvailable = false
                }
            }
        }
        .alert("로그아웃", isPresented: $showLogout) {
            Button("취소", role: .cancel) { }
            Button("로그아웃", role: .destructive) {
                onLogout()
            }
        } message: {
            Text("정말 로그아웃할까요?")
        }
    }

    // MARK: - 하단 버튼
    private var homeActionButtons: some View {
        HStack(spacing: 0) {
            Button(action: {
                if isAfter8pm {
                    showUVNotAvailable = true
                } else {
                    onOutingStart()
                }
            }) {
                Text("외출 시작")
                    .font(.medium16)
                    .foregroundStyle(.text01)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.yellow02, in: .capsule)
            }
        }
        .padding(.horizontal, 61)
        .padding(.bottom, 80)
    }
}

#Preview {
    HomeView(onOutingStart: { }, onAlertTap: { }, onLogout: { })
}
