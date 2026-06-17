//초안

/*import SwiftUI
 
 struct EggCharacterView: View {
 let exposureLevel: Double  // 0.0(하얀) ~ 1.0(까만)
 let statusMessage: String
 
 // 노출도에 따라 이미지 단계 결정
 var eggImageName: String {
 switch exposureLevel {
 case 0.0..<0.2:  return "egg_stage1"  // 하얀 계란
 case 0.2..<0.4:  return "egg_stage2"  // 살짝 노란
 case 0.4..<0.6:  return "egg_stage3"  // 노란
 case 0.6..<0.8:  return "egg_stage4"  // 갈색
 default:          return "egg_stage5"  // 많이 탄
 }
 }
 
 var body: some View {
 VStack(spacing: 16) {
 Image(eggImageName)
 .resizable()
 .scaledToFit()
 .frame(width: 160, height: 190)
 .animation(.easeInOut(duration: 0.4), value: eggImageName)
 
 Text(statusMessage)
 .font(.system(size: 15))
 .foregroundStyle(Color(hex: "888888"))
 }
 }
 }
 */
