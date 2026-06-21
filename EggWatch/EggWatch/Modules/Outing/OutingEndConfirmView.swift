import SwiftUI

struct OutingEndConfirmView: View {
    let onConfirm: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image("home_egg")
                .resizable()
                .scaledToFit()
                .frame(width: 218, height: 216)
            Text("외출을 종료할까요?")
                .font(.semiBold20)
                .foregroundStyle(.text01)
                .padding(.bottom, 6)
            Text("외출 모드가 종료되고 홈 모드로 돌아가요.")
                .font(.regular12)
                .foregroundStyle(.text01)
            Spacer()
            HStack(spacing: 12) {
                Button(action: onConfirm) {
                    Text("종료하기")
                        .font(.medium16)
                        .foregroundStyle(.text01)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.yellow02, in: .capsule)
                }
                Button(action: onCancel) {
                    Text("취소")
                        .font(.medium16)
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
