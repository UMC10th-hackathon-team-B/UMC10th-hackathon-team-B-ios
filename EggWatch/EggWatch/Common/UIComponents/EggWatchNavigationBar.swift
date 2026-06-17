import SwiftUI

struct EggWatchNavigationBar: View {
    let mode: OutingMode
    let alertCount: Int
    let onAlertTap: () -> Void
    
    var body: some View {
        HStack {
            Text("계란주의보")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)
            Spacer()
            Button(action: onAlertTap) {
                Image(systemName: "bell")
                    .font(.system(size: 24))
                    .foregroundStyle(.black)
                if alertCount > 0 {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                        .offset(x: 2, y: -2)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.white)
    }
}
