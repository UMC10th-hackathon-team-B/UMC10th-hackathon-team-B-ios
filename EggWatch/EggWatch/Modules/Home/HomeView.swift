import SwiftUI

struct HomeView: View {
    //ViewModel 연결 (추후 HomeViewModel로 분리)
    @State private var weather = WeatherInfo()
    @State private var exposureLevel: Double = 0.0
    @State private var alertCount: Int = 2
    @State private var showAlert: Bool = false
    @State private var sunscreenApplied: Bool = false
    
    var statusMesssage: String {
        switch exposureLevel {
        case 0..<0.2: return "안전한 계란이에요."
        case 0.2..<0.5: return "조금 그을리고 있어요."
        case 0.5..<0.8: return "선크림을 발라주세요!"
        default: return "많이 탔어요! 실내로 이동하세요."
        }
    }
    
    var body: some View{
        VStack(spacing: 0){
            EggWatchNavigationBar(
                mode: .home,
                alertCount: alertCount,
                onAlertTap: {
                    showAlert = true
                }
            )
            VStack(spacing: 28) {
                WeatherInfoCard(weather: weather)
                    .padding(.top, 24)
                //EggCharacterView
                Spacer(minLength: 20)
            }
            HomeActionButtons(
                onOutingStart: {
                    print("외출 시작")
                },
                onSunscreenRecord: {
                    //선크림 기록 + 계란 하얘지는 애니메이션
                    withAnimation(.spring(duration: 0.6)) {
                        exposureLevel = max(0.0, exposureLevel - 0.3)
                        sunscreenApplied = true
                    }
                }
            )
            .padding(.bottom, 32)
            .padding(.top, 16)
            .background(Color.white)
        }
    }
}

#Preview {
    HomeView()
}
