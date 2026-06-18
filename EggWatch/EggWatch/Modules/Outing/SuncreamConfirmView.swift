//
//  SuncreamConfirmView.swift
//  EggWatch
//
//  Created by 한지민 on 6/18/26.
//

import SwiftUI

struct SuncreamConfirmView: View {
    let onConfirm: () -> Void   //확인 버튼 탭 시 실행할 동작 (외부에서 주입)
    let onCancel: () -> Void    //취소 버튼 탭 시 실행할 동작 (외부에서 주입)

    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 4)
                .padding(.top, 12)
                .padding(.bottom, 28)

            Text("차단제를 다시 바르셨나요?")
                .font(.semiBold20)
                .foregroundStyle(.black)
                .padding(.bottom, 8)

            Text("다시 바른 것이 맞으면 현재 시간으로 기록돼요.")
                .font(.regular14)
                .foregroundStyle(Color(uiColor: .systemGray))
                .multilineTextAlignment(.center)

            Spacer()

            VStack(spacing: 12) {
                Button(action: onConfirm) {
                    Text("네, 다시 발랐어요")
                        .font(.semiBold16)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.black)
                        .clipShape(Capsule())
                }

                Button(action: onCancel) {
                    Text("취소")
                        .font(.semiBold16)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .overlay(Capsule().stroke(Color(uiColor: .systemGray4), lineWidth: 1))
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(Color.white)
        .presentationDetents([.height(260)])
        .presentationCornerRadius(20)
    }
}

#Preview {
    Color.clear //outing뷰 연결시 제거, 지금 뒷 배경이 없어서 임시로 해놓음.
        .sheet(isPresented: .constant(true)) {
            SuncreamConfirmView(
                onConfirm: { print("기록됨") },
                onCancel: { print("취소") }
            )
        }
}

//outing 연결 시에 outingview에 추가해야 될 코드, suncream은 위에 프리뷰 밑에 줄만 제거하면 됨.
//1. 상태 변수 — 기존 @State 변수들 아래에 추가
//@State private var showS

//2. onSunscreenRecord 클
//onSunscreenRecord: {
//    showSuncreamConfirm
//}

//3. .sheet(isPresented: $showAlert) 바로 아래에 추가
//.sheet(isPresented: $sho
//    SuncreamConfirmView(
//        onConfirm: { sho
//        onCancel: { showSuncreamConfirm = false }
//    )
//}
