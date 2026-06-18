//
//  LogoutView.swift
//  EggWatch
//
//  Created by 최윤석 on 6/18/26.
//


// 실제 팝업 UI만 담당
// 로그아웃 로직은 구현 X
import SwiftUI

struct LogoutView: View {
    // 부모 뷰에서 이 팝업을 닫을 수 있도록 상태 바인딩함
    @Binding var isPresented: Bool
    
    // 나중에 로그아웃 버튼을 눌렀을 때 실행될 코드를 외부에서 가저올 역할임
    var onLogout: () -> Void
    
    var body: some View {
        VStack(spacing: 11) {
            VStack(spacing: 5) {
                Text("로그아웃 하시겠습니까?")
                    .font(.semiBold16)
                    .foregroundColor(.black)
                
                Text("로그아웃하면 다시 카카오 로그인이 필요해요.")
                    .font(.regular14)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 8)
            
            // MARK: - 로그아웃 버튼
            Button(action: {
                isPresented = false // 팝업 닫기
                onLogout()          // 넘겨받은 로그아웃 구동 코드 실행
            }) {
                Text("로그아웃")
                    .font(.medium14)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color.black)
                    .cornerRadius(16)
            }
            
            // MARK: - 취소 버튼
            Button(action: {
                isPresented = false // 팝업만 닫기
            }) {
                Text("취소")
                    .font(.medium14)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color.white)
                    .cornerRadius(16)
            }
        }
        .padding(16)
        .frame(width: 200)
        .background(Color.yellow) // 핑크로 전체 크기 확인용
        .cornerRadius(16)

    }
}

#Preview {
    // 프리뷰용 가짜 바인딩 상수 & 가짜 함수
    LogoutView(isPresented: .constant(true)) {
        print("프리뷰에서 로그아웃 버튼 눌림!")
    }
}
