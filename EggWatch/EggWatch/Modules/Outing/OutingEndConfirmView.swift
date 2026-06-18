import SwiftUI

struct OutingEndConfirmView: View {
    let onConfirm: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            EggCharacterView(
                exposureLevel: 0.0,
                statusMessage: "" // 텍스트 없이
            )
            .padding(.bottom, 20)
            Text("외출을 종료할까요?")
                .font(.semiBold20)
                .foregroundStyle(.black)
                .padding(.bottom, 6)
            Text("외출 모드가 종료되고 홈 모드로 돌아가요.")
                .font(.regular12)
                .foregroundStyle(.black)
            Spacer()
            HStack(spacing: 12) {
                Button(action: onConfirm) {
                    Text("종료하기")
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
                Button(action: onCancel) {
                    Text("취소")
                        .font(.semiBold16)
                        .foregroundStyle(.black)
                        .frame(width: 84, height: 48)
                }
            }
            .padding(.horizontal, 37)
            .padding(.bottom, 80)
        }
        .background(Color.white)
    }
}

#Preview {
    OutingEndConfirmView(
        onConfirm: { print("종료") },
        onCancel:  { print("취소") }
    )
}
