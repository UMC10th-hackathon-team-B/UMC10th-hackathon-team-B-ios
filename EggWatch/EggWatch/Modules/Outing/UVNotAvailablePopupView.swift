import SwiftUI

struct UVNotAvailablePopupView: View {
    let onConfirm: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            popupIcon
                .padding(.bottom, 60)
            popupTitle
                .padding(.bottom, 4)
            popupMessage
                .padding(.bottom, 60)
            popupButton
        }
        .padding(.horizontal, 24)
        .padding(.top, 32)
        .padding(.bottom, 28)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 41)
    }

    private var popupIcon: some View {
        ZStack {
            Circle()
                .fill(Color.gray01)
                .frame(width: 56, height: 56)
            Text("🌙")
                .font(.system(size: 28))
        }
    }

    private var popupTitle: some View {
        Text("지금은 자외선 관리 시간이 아니에요")
            .font(.semiBold18)
            .foregroundStyle(.black)
            .multilineTextAlignment(.center)
    }

    private var popupMessage: some View {
        Text("저녁 8시 이후에는 자외선 노출 위험이 낮아져\n외출 모드를 시작하지 못 해요.")
            .font(.regular12)
            .foregroundStyle(Color.gray02)
            .multilineTextAlignment(.center)
    }

    private var popupButton: some View {
        Button(action: onConfirm) {
            Text("확인")
                .font(.medium16)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
        }
        .glassEffect(
            .regular
                .tint(Color.yellow01.opacity(0.6))
                .interactive(),
            in: .capsule
        )
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.4).ignoresSafeArea()
        UVNotAvailablePopupView {
            print("확인")
        }
    }
}
