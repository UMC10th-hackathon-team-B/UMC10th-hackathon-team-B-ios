import SwiftUI

struct AlertView: View {
    @Binding var alertCount: Int
    @Environment(\.dismiss) var dismiss
 
    var body: some View {
        NavigationStack {
            VStack {
                Text("알림함")
                    .font(.headline)
                Spacer()
                Text("알림 없음")
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("닫기") { dismiss() }
                }
            }
        }
    }
}
