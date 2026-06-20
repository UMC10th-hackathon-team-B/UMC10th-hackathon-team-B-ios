//
//  SplashView.swift
//  EggWatch
//
//  Created by 최윤석 on 6/17/26.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                Spacer()
                
                VStack(spacing: 20) {
                    Image("egg1")
                        .resizable()
                        .frame(width: 160, height: 216)
                    
                    VStack(spacing: 6) {
                        Text("계란주의보")
                            .font(.semiBold20)
                        
                        Text("오늘도 계란이를 지켜볼까요?")
                            .font(.medium14)
                    }
                }
                Spacer()
                
                Button(action: {
                    print("시작하기 버튼 클릭함")
                }) {
                    Text("시작하기")
                        .font(.semiBold16)
                        .foregroundStyle(.black)
                        .frame(width: 280, height: 48)
                        .background(.yellow01)
                        .cornerRadius(1000)
                }
                .padding(.bottom, 80)
            }
        }
    }
}

#Preview {
    SplashView()
}
