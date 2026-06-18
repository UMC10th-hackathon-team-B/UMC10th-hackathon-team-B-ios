import SwiftUI

struct HomeView: View {
    let onOutingStart: () -> Void
    let onAlertTap: () -> Void
    
    //ViewModel 연결 (추후 HomeViewModel로 분리)
    @State private var weather = WeatherInfo()
    @State private var exposureLevel: Double = 0.0
    @State private var alertCount: Int = 2
    @State private var showAlert: Bool = false
    
    var statusMessage: String {
        switch exposureLevel {
        case 0..<0.2: return "안전한 계란이에요."
        case 0.2..<0.5: return "조금 그을리고 있어요."
        case 0.5..<0.8: return "선크림을 발라주세요!"
        default: return "많이 탔어요! 실내로 이동하세요."
        }
    }
    
    var body: some View{
        VStack(spacing: 0) {
            EggWatchNavigationBar(
                mode: .home,
                alertCount: alertCount,
                onAlertTap: {
                    onAlertTap()
                }
            )
            .padding(.horizontal, 22)
            VStack(spacing: 0) {
                WeatherInfoCard(weather: weather)
                    .padding(.bottom, 70)
                EggCharacterView(
                        exposureLevel: exposureLevel,
                        statusMessage: statusMessage
                    )
                Spacer(minLength: 20)
            }
            .padding(.horizontal, 43)
            Spacer()
            HomeActionButtons(
                onOutingStart: {
                    onOutingStart()
                },
                onSunscreenRecord: {
                    //계란 효과
                }
            )
            .padding(.horizontal, 61)
            .padding(.bottom, 80)
            .background(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    HomeView(
        onOutingStart: { }, onAlertTap: { }
    )
}
