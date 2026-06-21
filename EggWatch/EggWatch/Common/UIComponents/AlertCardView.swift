import SwiftUI

struct AlertCardView: View {
    let item: NotificationItem
    var onTap: () -> Void = {}

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Text("🥚")
                .font(.system(size: 18))
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline) {
                    Text(item.title)
                        .font(.medium13)
                        .foregroundStyle(.text01)
                    Spacer()
                    Text(formattedDateTime)
                        .font(.regular9)
                        .foregroundStyle(Color.gray02)
                }
                Text(item.content)
                    .font(.regular11)
                    .foregroundStyle(Color.gray02)
            }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.gray01))
        .onTapGesture { onTap() }
    }

    // "6.21 오후 6:19" 형태로 날짜+시간 조합
    private var formattedDateTime: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")

        // createdAt 형식 시도 (타임존 있는 것 / 없는 것 둘 다 처리)
        let formats = ["yyyy-MM-dd'T'HH:mm:ssZ", "yyyy-MM-dd'T'HH:mm:ss"]
        var date: Date?
        for format in formats {
            formatter.dateFormat = format
            if let d = formatter.date(from: item.createdAt) {
                date = d
                break
            }
        }

        guard let date else { return item.createdTimeText }

        formatter.dateFormat = "M.d"
        let datePart = formatter.string(from: date)
        return "\(datePart) \(item.createdTimeText)"
    }
}

#Preview {
    AlertCardView(item: NotificationItem(
        notificationId: 1,
        type: .eggDanger,
        title: "차단제를 다시 발라주세요.",
        content: "외출 세션 시작 후 2시간이 지났어요.",
        createdAt: "2026-06-21T18:19:00",
        createdTimeText: "오후 6:19",
        isRead: false
    ))
    .padding()
}
