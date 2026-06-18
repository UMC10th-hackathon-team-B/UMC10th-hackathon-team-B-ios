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
            
            // MARK: - 네비게이션 바
            HStack {
                Button(action: {
                    onBack()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .frame(width: 24, height: 24)
                }
                
                Text("외출 시작")
                    .font(.medium16)
                    .padding(.leading, 8)
                
                Spacer()
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 24)
            .background(.white)
            
            // MARK: - 메인 질문 및 안내 문구
            VStack(alignment: .leading, spacing: 0) {
                Text("자외선 차단제를 언제 발랐나요?")
                    .font(.regular12) //regular14인데 아직 크기추가가 안됌
                
                Text("선택한 시간을 기준으로 외출 세션이 시작돼요.")
                    .font(.regular12) //regular9인데 아직 크기 추가가 안됌
                    .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59)) //컬러 추가시 변경 필요함
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 20)
            .padding(.leading, 35)
            
            // MARK: - 선택 리스트
            VStack(spacing: 0) {
                ForEach(Array(options.enumerated()), id: \.element) { index, option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        HStack {
                            Text(option)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(selectedOption == option ? .white : Color(red: 44/255, green: 44/255, blue: 44/255))
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 42)
                        .background(selectedOption == option ? Color(red: 0.21, green: 0.21, blue: 0.21) : Color(red: 0.96, green: 0.96, blue: 0.96))
                    }
                    
                    // 마지막 항목 제외 구분선
                    if index < options.count - 1 {
                        Divider()
                            .padding(.horizontal, 16)
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 35)
            
            Spacer()
            
            // 4. 하단 외출하기 버튼
            Button(action: {
                onOutingStart()
                }
            ) {
                Text("외출하기")
                    .font(.semiBold20) //semiBold16 추가 후 수정필요
                    .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
                    .frame(width: 280, height: 48)
                    .background(Color(red: 1, green: 0.8, blue: 0).opacity(0.2))
                    .cornerRadius(1000)
            }
            .disabled(selectedOption == nil)
            .padding(.bottom, 36)
        }
    }
}

#Preview {
    UVSelectionView(
        onBack: { }, onOutingStart: { }
    )
}
