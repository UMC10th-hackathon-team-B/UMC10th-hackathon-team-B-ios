//
//  UVSelectionView.swift
//  EggWatch
//
//  Created by 최윤석 on 6/18/26.
//

import SwiftUI

struct UVSelectionView: View {
    let onBack: () -> Void
    let onOutingStart: (SunscreenAppliedOption) -> Void

    @State private var selectedOption: String? = nil

    let options = ["5분 전", "15분 전", "30분 전", "1시간 전", "2시간 전", "안 발랐어요"]

    private func mapToOption(_ text: String) -> SunscreenAppliedOption {
        switch text {
        case "5분 전": return .before5Minutes
        case "15분 전": return .before15Minutes
        case "30분 전": return .before30Minutes
        case "1시간 전": return .before60Minutes
        case "2시간 전": return .before120Minutes
        default: return .none
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            UVSelectionNavigation
                .padding(.horizontal, 22)
                .padding(.bottom, 12)
            UVSelectionTitle
                .padding(.horizontal, 35)
                .padding(.bottom,12)
            UVSelectionList
                .padding(.horizontal, 35)
            Spacer()
            UVSelectionActionButtons
        }
    }

    // MARK: - 네비게이션 바
    private var UVSelectionNavigation: some View {
        HStack(spacing: 8) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.text01)
                    .frame(width: 24, height: 24)
            }
            Text("외출 시작")
                .font(.medium16)
                .foregroundStyle(.text01)
            Spacer()
        }
        .padding(.vertical, 24)
    }

    // MARK: - 메인 질문 및 안내 문구
    private var UVSelectionTitle: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("자외선 차단제를 언제 발랐나요?")
                .font(.semiBold15)
                .foregroundStyle(Color.text01)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
    }

    // MARK: - 선택 리스트
    private var UVSelectionList: some View {
        VStack(spacing: 8) {
            ForEach(options, id: \.self) { option in
                let isSelected = selectedOption == option
                Button(action: { selectedOption = option }) {
                    HStack {
                        Text(option)
                            .font(.regular13)
                            .foregroundStyle(isSelected ? .white : .text01)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(isSelected ? Color.text01 : Color.gray01,
                                in: RoundedRectangle(cornerRadius: 16))
                }
            }
        }
    }

    // MARK: - 하단 버튼
    private var UVSelectionActionButtons: some View {
        HStack(spacing: 0) {
            Button(action: {
                if let option = selectedOption {
                    onOutingStart(mapToOption(option))
                }
            }) {
                Text("외출하기")
                    .font(.medium16)
                    .foregroundStyle(.text01)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.yellow02, in: .capsule)
            }
            .disabled(selectedOption == nil)
        }
        .padding(.horizontal, 61)
        .padding(.bottom, 80)
    }
}

#Preview {
    UVSelectionView(
        onBack: { }, onOutingStart: { _ in }
    )
}
