//
//  UVTimeoutPopUpView.swift
//  EggWatch
//
//  Created by 최윤석 on 6/18/26.
//
import SwiftUI

struct UVTimeoutPopupView: View {
    @Binding var isPresented: Bool
    
    // 확인 버튼을 눌렀을 때 실행할 액션 (홈모드로 이동)
    var onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(Color(red: 0.95, green: 0.96, blue: 0.96))
                    .frame(width: 56, height: 56)
                
                Text("🌙")
                    .font(.system(size: 28))
            }
            .padding(.top, 32)
            
            Text("자외선 관리 시간이 종료됐어요")
                .font(.semiBold16)
                .padding(.top, 16)
            
            Text("저녁 8시 이후에는 외출 모드가 자동으로 종료돼요. 외출 기록을 저장하고 홈 모드로 이동할게요.")
                .font(.regular12)
                .foregroundStyle(Color(red: 0.42, green: 0.45, blue: 0.51))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 22)
            
            Text("현재 시간 ≥ 20:00 감지 · 선택지 없음 · 닫기 불가")
                .font(.regular12)
                .foregroundStyle(Color.gray)
                .padding(.vertical, 6)
                .padding(.horizontal, 16)
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(10)
                .padding(.vertical, 16)
           
            Button(action: {
                isPresented = false
                onConfirm()
            }) {
                Text("확인하고 홈으로 이동")
                    .font(.medium14)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(Color(red: 0.11, green: 0.11, blue: 0.12))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 28)
        }
        .frame(width: 322)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.24), radius: 16, x: 0, y: 8)

    }
}


#Preview {
    ZStack {
        Color.black.opacity(0.4)
            .ignoresSafeArea()
        
        // 팝업 창 본체 호출 시 .constant(true) 추가하여 프리뷰 에러 해결
        UVTimeoutPopupView(isPresented: .constant(true)) {
            print("확인 버튼 눌림 -> 홈 화면 전환 로직 실행")
        }
    }
}
