//
//  SplashView.swift
//  EggWatch
//
//  Created by JOON on 6/17/26.
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
                            .font(.system(size: 20, weight: .semibold))

                        Text("오늘도 계란이를 지켜볼까요?")
                            .font(.system(size: 14, weight: .medium))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    print("시작하기 버튼 클릭됨")
                }) {
                    Text("시작하기")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(width: 280, height: 48)
                        .background(Color.yellow)
                        .cornerRadius(1000)
                }
                .padding(.bottom, 24)
            }
        }
    }
}

#Preview {
    SplashView()
}
