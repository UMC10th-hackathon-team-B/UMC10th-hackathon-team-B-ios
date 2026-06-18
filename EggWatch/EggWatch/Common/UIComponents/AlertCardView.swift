import SwiftUI

struct AlertCardView: View {
    let item: AlertItem

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image("egg1")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline) {
                    Text(item.title)
                        .font(.medium12)
                        .foregroundStyle(.black)
                    Spacer()
                    Text(item.time)
                        .font(.regular9)
                        .foregroundStyle(Color.gray02)
                }
                Text(item.message)
                    .font(.regular9)
                    .foregroundStyle(Color.gray02)
            }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 16) .fill(Color.gray01))
    }
}

#Preview {
    AlertCardView(item: AlertItem(
        title: "차단제를 다시 발라주세요.",
        message: "외출 세션 시작 후 2시간이 지났어요.",
        time: "13:00"
    ))
    .padding()
}
