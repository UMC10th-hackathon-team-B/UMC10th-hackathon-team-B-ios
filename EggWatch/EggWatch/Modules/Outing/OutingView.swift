import SwiftUI

struct OutingView: View {
    @State private var weather = WeatherInfo()
    @State private var exposureLevel: Double = 0.0
    @State private var alertCount: Int = 2
    @State private var showAlert: Bool = false
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
    
    var body: some View{
        VStack(spacing: 0) {
            EggWatchNavigationBar(
                mode: .outing,
                alertCount: alertCount,
                onAlertTap: {
                    showAlert = true
                },
                onRefreshTap: {
                    /* 날씨 새로고침 */
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
            OutingActionButtons(
                lastRecordTime: lastRecordTime, lastRecordAgo: lastRecordAgo, onOutingEnd: {
                    print("외출 종료")
                },
                onSunscreenRecord: {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        exposureLevel = max(0.0, exposureLevel - 0.3)
                        lastRecordTime = currentTimeString()
                        lastRecordAgo = "방금 전"
                    }
                }
            )
            .padding(.horizontal, 33)
            .padding(.bottom, 80)
            .background(Color.white)
        }
        .sheet(isPresented: $showAlert){
            //AlertView 연결
        }
    }
    private func currentTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H시 mm 분"
        return formatter.string(from: Date())
    }
}

#Preview {
    OutingView()
}

