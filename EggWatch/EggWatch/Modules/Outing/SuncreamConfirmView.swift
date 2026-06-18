import SwiftUI

struct SuncreamConfirmView: View {
    let onConfirm: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            suncreamTitle
            suncreamButtons
        }
        .padding(.horizontal, 41)
        .padding(.vertical, 24)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .presentationDetents([.height(277)])
        .presentationCornerRadius(24)
        .presentationDragIndicator(.hidden)
    }

    // MARK: - 타이틀
    private var suncreamTitle: some View {
        VStack(spacing: 8) {
            Text("차단제를 다시 바르셨나요?")
                .font(.semiBold16)
                .foregroundStyle(.black)
            Text("다시 바른 것이 맞으면 현재 시간으로 기록돼요.")
                .font(.regular12)
                .foregroundStyle(Color.gray02)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
    }

    // MARK: - 하단 버튼
    private var suncreamButtons: some View {
        VStack(spacing: 8) {
            Button(action: onConfirm) {
                Text("네, 다시 발랐어요")
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
                Text("아니요, 안 발랐어요.")
                    .font(.semiBold16)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .glassEffect(
                        .regular
                            .tint(Color.white.opacity(0.6))
                            .interactive(),
                        in: .capsule
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }
}

#Preview {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            SuncreamConfirmView(
                onConfirm: { print("기록됨") },
                onCancel: { print("취소") }
            )
        }
}
