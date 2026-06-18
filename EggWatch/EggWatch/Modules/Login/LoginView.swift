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
        }
        .background(Color(.systemBackground))
    }
    
    //MARK: - 계란 이미지
    private var eggImage: some View {
        Image("egg1")
            .resizable()    //이미지 크기 바꿔도 된다고 허락하는 거
            .scaledToFit()  //이미지 비율 유지
            .frame(width: 160, height: 216)
    }
    
    //MARK: - 타이틀 / 서브타이틀
    private var titleGroup: some View {
        VStack(spacing: 6) {
            Text("계란 주의보")
                .font(.semiBold20)
                .foregroundStyle(Color.black)
            Text("오늘도 계란이를 지켜볼까요?")
                .font(.regular14)
                .foregroundStyle(Color.black)
        }
    }
    
    //MARK: - 카카오 로그인 버튼
    private var kakaoButton: some View {
        Button {
            // TODO: 로그인 연동 코드 자리
        } label: {
            Text("카카오로 시작하기")
                .font(.semiBold16)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
        }
        .glassEffect(
            .regular
                .tint(Color.yellow01.opacity(0.6))
                .interactive(),
            in: .capsule
        )
        .padding(.horizontal, 61)
        .padding(.bottom, 80)
    }
}

#Preview {
    LoginView()
}
