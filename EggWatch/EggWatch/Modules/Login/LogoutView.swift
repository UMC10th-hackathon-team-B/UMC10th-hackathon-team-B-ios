//
//  LogoutView.swift
//  EggWatch
//
//  Created by 최윤석 on 6/18/26.
//

import SwiftUI

struct LogoutView: View {
    @Binding var isPresented: Bool
    var onLogout: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("로그아웃")
                    .font(.semiBold16)
                    .foregroundColor(.black)
                Text("정말 로그아웃할까요?")
                    .font(.regular14)
                    .foregroundColor(.gray)
            }
            HStack(spacing: 8) {
                Button(action: { isPresented = false }) {       // 팝업만 닫기
                    Text("취소")
                        .font(.medium14)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.gray01)
                        .cornerRadius(12)
                }
                Button(action: {
                    isPresented = false     // 팝업 닫기
                    onLogout()              // 로그아웃 실행
                }) {
                    Text("로그아웃")
                        .font(.medium14)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.gray01)
                        .cornerRadius(12)
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 40)
    }
}

#Preview {
    LogoutView(isPresented: .constant(true)) {
        print("프리뷰에서 로그아웃 버튼 눌림!")
    }
}
