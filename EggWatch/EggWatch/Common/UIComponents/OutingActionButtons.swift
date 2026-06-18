import SwiftUI

struct OutingActionButtons: View {
    let lastRecordTime: String //"3시 33분"
    let lastRecordAgo: String //"1시간 전"
    let onOutingEnd: () -> Void
    let onSunscreenRecord: () -> Void
    
    var body: some View {
        VStack(spacing: 10){
            HStack(spacing: 0) {
                Text("마지막 기록: \(lastRecordTime) ")
                    .font(.regular9)
                    .foregroundStyle(.gray)
                Text("(\(lastRecordAgo))")
                    .font(.regular9)
                    .foregroundStyle(.gray)
            }
            .underline()
            HStack(spacing: 12) {
                Button(action: onOutingEnd) {
                    Text("외출 종료")
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
                Button(action: onSunscreenRecord) {
                    Text("자외선 차단제 기록")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(width: 164, height: 48)
                        .glassEffect(
                            .regular
                                .tint(Color.white.opacity(0.6))
                                .interactive(),
                            in: .capsule
                        )
                }
            }
        }
    }
}

