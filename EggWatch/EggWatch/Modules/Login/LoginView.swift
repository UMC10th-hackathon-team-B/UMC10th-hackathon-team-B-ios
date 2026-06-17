//
//  LoginView.swift
//  EggWatch
//
//  Created by JOON on 6/17/26.
//

import SwiftUI

struct LoginView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            eggImage
            
            titleGroup
                .padding(.top, 20)
            
            Spacer()
            
            kakaoButton
                .padding(.horizontal, 20)   //양쪽 여백
                .padding(.bottom, 50)
        }
        .background(Color(.systemBackground))   //.systemBackground를 쓰면 라이트 모드에는 흰색 다크 모드에는 거의 검정색으로 바뀜. white로 하면 다크 모드에서도 흰 색.
    }
    
    //MARK: 계란 이미지
    private var eggImage: some View {
        Image("egg1")
            .resizable()    //이미지 크기 바꿔도 된다고 허락하는 거
            .scaledToFit()  //이미지 비율 유지
            .frame(width: 150)
    }
    
    //MARK: 타이틀 / 서브타이틀
    private var titleGroup: some View {
        VStack(spacing: 10) {
            Text("계란 주의보")
                .font(.chiron(.semi, size: 28))
            
            Text("오늘도 계란이를 지켜볼까요?")
                .font(.chiron(.regular, size: 16))   // 보통 → regular
                .foregroundStyle(.secondary)    //디자인 나오면 secondary-->디자인 색상으로 바꾸기.
        }
    }
    
    //MARK: 카카오 로그인 버튼
    private var kakaoButton: some View {
        Button {
            // TODO: 로그인 연동 코드 자리
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "message.fill")   //애플이 기본 제공하는 SF Symbols 아이콘 이미지 사용하시면 그때 이미지 이름으로 바꾸면 됨.
                Text("카카오로 시작하기")
            }
            .font(.chiron(.semi, size: 17))
            .frame(maxWidth: .infinity) //기기마다 화면이 다르게 때문에 가로넓이 최대로 주고 위해서 horisontal로 여백 설정
            .frame(height: 56)  //세로 넓이
        }
        .background(Color.yellow01) //일단 yellow01로 해놓음
        .foregroundStyle(.black.opacity(0.85))  //opacity 글자 불투명하게 해주는 거 1에 가까울 수록 진해짐
        .clipShape(RoundedRectangle(cornerRadius: 14))  //모서리 둥근 사각형
    }
}

#Preview {
    LoginView()
}
