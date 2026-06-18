//
//  UVSelectionView.swift
//  EggWatch
//
//  Created by 최윤석 on 6/18/26.
//

import SwiftUI

struct UVSelectionView: View {
    let onBack: () -> Void
    let onOutingStart: () -> Void

    @State private var selectedOption: String? = nil

    let options = ["5분 전", "15분 전", "30분 전", "1시간 전", "2시간 전", "안 발랐어요"]

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
                    .foregroundStyle(.black)
                    .frame(width: 24, height: 24)
            }
            Text("외출 시작")
                .font(.medium16)
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 24)
    }

    // MARK: - 메인 질문 및 안내 문구
    private var UVSelectionTitle: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("자외선 차단제를 언제 발랐나요?")
                .font(.regular14)
                .foregroundColor(Color.black)
            Text("선택한 시간을 기준으로 외출 세션이 시작돼요.")
                .font(.regular12)
                .foregroundColor(Color.gray02)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
    }

    // MARK: - 선택 리스트
    private var UVSelectionList: some View {
        VStack(spacing: 0) {
            ForEach(Array(options.enumerated()), id: \.element) { index, option in
                Button(action: {
                    selectedOption = option
                }) {
                    HStack {
                        Text(option)
                            .font(.regular14)
                            .foregroundColor(selectedOption == option ? .white : .black)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 42)
                    .background(selectedOption == option ? .text01 : .gray01)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - 하단 버튼
    private var UVSelectionActionButtons: some View {
        HStack(spacing: 0) {
            Button(action: onOutingStart) {
                Text("외출하기")
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
            .disabled(selectedOption == nil)
        }
        .padding(.horizontal, 61)
        .padding(.bottom, 80)
    }
}

#Preview {
    UVSelectionView(
        onBack: { }, onOutingStart: { }
    )
}
