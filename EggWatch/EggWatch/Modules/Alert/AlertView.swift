import SwiftUI

struct AlertView: View {
    let onBack: () -> Void

    // TODO: 백엔드 연결 시 외부에서 주입받도록 교체
    let alerts: [AlertItem] = [
        AlertItem(title: "차단제를 다시 발라주세요.", message: "외출 세션 시작 후 2시간이 지났어요.", time: "13:00"),
        AlertItem(title: "자외선 차단제를 발라주세요.", message: "계란이가 많이 익었어요. 자외선 노출에 주의해주세요.", time: "10:34")
    ]

    var body: some View {
        VStack(spacing: 0) {
            alertNavigation
                .padding(.horizontal, 22)
                .padding(.bottom, 12)
            alertList
                .padding(.horizontal, 35)
        }
        .background(Color.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - 네비게이션 바
    private var alertNavigation: some View {
        HStack(spacing: 8) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
                    .frame(width: 24, height: 24)
            }
            Text("알림")
                .font(.medium16)
                .foregroundStyle(.black)
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 24)
        .background(Color.white)
    }

    // MARK: - 알림 목록
    private var alertList: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(alerts) { item in
                    AlertCardView(item: item)
                }
            }
        }
    }
}

#Preview {
    AlertView(onBack: {})
}

