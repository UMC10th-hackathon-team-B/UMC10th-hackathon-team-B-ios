//
//  AgreementView.swift
//  EggWatch
//
//  Created by 한지민 on 6/20/26.
//

import SwiftUI
import Moya

struct AgreementView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var agreeAll: Bool = false
    @State private var agreeService: Bool = false
    @State private var agreePrivacy: Bool = false
    @State private var agreeLocation: Bool = false

    var isAllAgreed: Bool {
        agreeService && agreePrivacy && agreeLocation
    }
    
    let signupToken: String?                            // 신규 회원일 때 받은 임시 토큰
    private let provider = MoyaProvider<AuthRouter>()   // Moya API 호출 객체

    let onConfirm: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            AgreementNavigation
                .padding(.horizontal, 22)
                .padding(.bottom, 12)
            VStack(spacing: 0) {
                AgreementTitle
                    .padding(.bottom, 12)
                AgreementCheckList
            }
            .padding(.horizontal, 35)
            Spacer()
            AgreementBottomButtons
        }
        .background(Color.white)
    }

    // MARK: - 네비게이션 바
    private var AgreementNavigation: some View {
        HStack(spacing: 8) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.black)
                    .frame(width: 24, height: 24)
            }
            .buttonStyle(.plain)

            Text("약관 동의")
                .font(.medium16)
                .foregroundStyle(Color.black)
            Spacer()
        }
        .frame(height: 72)
    }

    // MARK: - 타이틀
    private var AgreementTitle: some View {
        Text("서비스 이용을 위해 동의가 필요해요.")
            .font(.regular14)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
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
            CheckRow(isChecked: $agreeService, title: "[필수] 서비스 이용약관 동의", isBold: false, showArrow: true)
                .onChange(of: agreeService) { _, _ in syncAll() }

            CheckRow(isChecked: $agreePrivacy, title: "[필수] 개인정보 처리방침 동의", isBold: false, showArrow: true)
                .onChange(of: agreePrivacy) { _, _ in syncAll() }

            CheckRow(isChecked: $agreeLocation, title: "[필수] 위치정보 이용 동의", isBold: false, showArrow: true)
                .onChange(of: agreeLocation) { _, _ in syncAll() }
        }
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.gray01))
    }

    // MARK: - 하단 버튼
    private var AgreementBottomButtons: some View {
        Button(action: { if isAllAgreed { registerUser() } }) {
            Text("동의하고 시작하기")
                .font(.semiBold16)
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
        .disabled(!isAllAgreed)
        .padding(.horizontal, 61)
        .padding(.bottom, 80)
    }

    // MARK: - 전체 동의 동기화
    private func syncAll() {
        agreeAll = agreeService && agreePrivacy && agreeLocation
    }
    // MARK: -약관 동의 API 호출
    private func registerUser() {
        guard let signupToken else {
            dismiss()
            onConfirm()
            return
        }
        provider.request(.register(signupToken: signupToken)) { result in
            switch result {
            case .success(let response):
                guard let wrappedResponse = try? response.map(APIResponse<UserResponse>.self) else { return }  // data 래퍼 벗겨서 파싱
                let userResponse = wrappedResponse.data
                DispatchQueue.main.async {
                    KeychainService.save(key: KeychainService.Keys.accessToken, value: userResponse.auth.accessToken)
                    KeychainService.save(key: KeychainService.Keys.refreshToken, value: userResponse.auth.refreshToken)
                    dismiss()
                    onConfirm()
                }
            case .failure(let error):
                print("약관 동의 실패: \(error)")
            }
        }
    }
}



// MARK: - 체크박스 행 (공통 컴포넌트)
struct CheckRow: View {
    @Binding var isChecked: Bool
    let title: String
    let isBold: Bool
    let showArrow: Bool

    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                isChecked.toggle()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(isChecked ? Color.gray02 : Color.clear)
                        .frame(width: 20, height: 20)
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(
                            isChecked ? Color.gray02 : Color.gray02,
                            lineWidth: 2
                        )
                        .frame(width: 20, height: 20)
                    if isChecked {
                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
            }
            Text(title)
                .font(isBold ? .semiBold12 : .regular12)
                .foregroundStyle(.black)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
        .onTapGesture {
            isChecked.toggle()
        }
    }
}

#Preview {
    AgreementView(signupToken: nil, onConfirm: { print("동의 완료") })
}
