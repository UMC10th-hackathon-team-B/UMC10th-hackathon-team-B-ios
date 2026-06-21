import SwiftUI

struct EggWatchNavigationBar: View {
    let mode: OutingMode
    let alertCount: Int
    let onAlertTap: () -> Void
    var onRefreshTap: (() -> Void)? = nil
    var onLogoutTap: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 20) {
            switch mode {
            case .home:
                Text("계란주의보")
                    .font(.medium16)
                    .foregroundStyle(.text01)
            case .outing:
                Text("외출 중")
                    .font(.medium16)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.yellow02)
                    )
            }
            Spacer()
            Button(action: {onRefreshTap?() }) {
                Image(.clockwise)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.text01)
            }
            Button(action: onAlertTap) {
                Image(.bell)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.text01)
            }
            Button(action: { onLogoutTap?() }) {
                Image(.logout)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.text01)
            }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 24)
        .background(Color.white)
    }
}
