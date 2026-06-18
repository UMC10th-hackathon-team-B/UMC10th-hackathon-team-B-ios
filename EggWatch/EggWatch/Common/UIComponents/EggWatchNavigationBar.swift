import SwiftUI

struct EggWatchNavigationBar: View {
    let mode: OutingMode
    let alertCount: Int
    let onAlertTap: () -> Void
    var onRefreshTap: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 16) {
            switch mode {
            case .home:
                Text("계란주의보")
                    .font(.medium16)
                    .foregroundStyle(.black)
            case .outing:
                Text("외출 중")
                    .font(.medium16)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.yellow01)
                    )
            }
            Spacer()
            Button(action: {onRefreshTap?() }) {
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.black)
            }
            Button(action: onAlertTap) {
                Image(systemName: "bell")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.black)
                if alertCount > 0 {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                        .offset(x: -10, y: -10)
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 26)
        .background(Color.white)
    }
}
