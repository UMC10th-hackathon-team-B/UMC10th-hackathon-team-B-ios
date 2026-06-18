import SwiftUI

struct HomeActionButtons: View {
    let onOutingStart: () -> Void
    let onSunscreenRecord: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: onOutingStart) {
                Text("외출 시작")
                    .font(.semiBold16)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .glassEffect(
                        .regular
                            .tint(Color.yellow01.opacity(0.6))
                            .interactive(),
                        in: .capsule
                        )
            }
            /*
            Button(action: onSunscreenRecord) {
                Text("자외선 차단제 기록")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .frame(width: 164, height: 48)
                    .background(
                        Capsule()
                            .stroke(Color.black, lineWidth: 1.5)
                    )
            }
             */
        }
    }
}
