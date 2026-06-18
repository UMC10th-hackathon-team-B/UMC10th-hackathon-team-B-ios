import SwiftUI

struct AgreementView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var agreeAll: Bool = false
    @State private var agreeService: Bool = false
    @State private var agreePrivacy: Bool = false
    @State private var agreeLocation: Bool = false
    
    var isAllAgreed: Bool {
        agreeService && agreePrivacy && agreeLocation
    }
    
    let onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            AgreementNavigation
                .padding(.horizontal, 20)
            Divider()
            VStack(spacing: 0) {
                AgreementTitle
                AgreementCheckList
            }
            Spacer()
            AgreementBottomButtons
        }
        .background(Color.white)
    }
    
    // MARK: - 네비게이션 바
    private var AgreementNavigation: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.black)
                    .frame(width: 44, height: 44)
                    .glassEffect(.regular, in: Circle())
            }
            .buttonStyle(.plain)

            Spacer()

            Text("약관 동의")
                .font(.semiBold16)
                .foregroundStyle(Color.black)

            Spacer()

            Color.clear.frame(width: 44, height: 44)
        }
        .frame(height: 44)
    }
    
    // MARK: - 타이틀
        private var AgreementTitle: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("서비스 이용을 위해 동의가 필요해요")
                    .font(.semiBold20)
                    .foregroundStyle(.black)
                Text("필수 항목에 모두 동의하면 시작할 수 있어요.")
                    .font(.regular14)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 28)
            .padding(.bottom, 24)
        }

        // MARK: - 체크리스트
        private var AgreementCheckList: some View {
            VStack(spacing: 0) {
                CheckRow(isChecked: $agreeAll, title: "전체 동의", isBold: true, showArrow: false)
                    .onChange(of: agreeAll) { _, newValue in
                        agreeService = newValue
                        agreePrivacy = newValue
                        agreeLocation = newValue
                    }

                Divider()
                    .padding(.horizontal, 16)

                CheckRow(isChecked: $agreeService, title: "[필수] 서비스 이용약관 동의", isBold: false, showArrow: true)
                    .onChange(of: agreeService) { _, _ in syncAll() }

                Divider().padding(.horizontal, 16)

                CheckRow(isChecked: $agreePrivacy, title: "[필수] 개인정보 처리방침 동의", isBold: false, showArrow: true)
                    .onChange(of: agreePrivacy) { _, _ in syncAll() }

                Divider().padding(.horizontal, 16)

                CheckRow(isChecked: $agreeLocation, title: "[필수] 위치정보 이용 동의", isBold: false, showArrow: true)
                    .onChange(of: agreeLocation) { _, _ in syncAll() }
            }
            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
            .padding(.horizontal, 20)
        }

        // MARK: - 하단 버튼
        private var AgreementBottomButtons: some View {
            VStack(spacing: 12) {
                Button(action: { if isAllAgreed { dismiss(); onConfirm() } }) {
                    Text("동의하고 시작하기")
                        .font(.semiBold16)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(isAllAgreed ? Color.black : Color.black.opacity(0.3))
                        )
                }
                .disabled(!isAllAgreed)

                Button(action: { dismiss() }) {
                    Text("취소")
                        .font(.semiBold16)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.black.opacity(0.15), lineWidth: 1.5)
                        )
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }

        // MARK: - 전체 동의 동기화
        private func syncAll() {
            agreeAll = agreeService && agreePrivacy && agreeLocation
        }
    }

    // MARK: - 체크박스 행 (공통 컴포넌트)
    struct CheckRow: View {
        @Binding var isChecked: Bool
        let title: String
        let isBold: Bool
        let showArrow: Bool

        var body: some View {
            HStack(spacing: 14) {
                Button(action: {
                    isChecked.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(isChecked ? Color.black : Color.white)
                            .frame(width: 24, height: 24)
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(
                                isChecked ? Color.black : Color.black.opacity(0.2),
                                lineWidth: 1.5
                            )
                            .frame(width: 24, height: 24)
                        if isChecked {
                            Image(systemName: "checkmark")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(.white)
                        }
                    }
                }
                Text(title)
                    .font(isBold ? .semiBold16 : .regular14)
                    .foregroundStyle(.black)
                Spacer()
                if showArrow {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundStyle(.black.opacity(0.3))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 18)
            .contentShape(Rectangle())
            .onTapGesture {
                isChecked.toggle()
            } //터치 감지기
        }
    }

#Preview {
    AgreementView(onConfirm: {
        print("동의 완료")
    })
}
