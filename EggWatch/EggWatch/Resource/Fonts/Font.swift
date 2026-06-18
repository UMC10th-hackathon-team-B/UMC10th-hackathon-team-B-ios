//
//  Font.swift
//  EggWatch
//
//  Created by 한지민 on 6/17/26.
//

import SwiftUI

extension Font {
    enum Chiron {
        case semi
        case medium
        case regular
        case custom(String)
        
        var value: String {
            switch self {
            case .semi:
                return "ChironGoRoundTC-SemiBold"   // 파일 받은 뒤 실제 이름으로 교체 필요
            case .medium:
                return "ChironGoRoundTC-Medium"     // 파일 받은 뒤 실제 이름으로 교체 필요
            case .regular:
                return "ChironGoRoundTC-Regular"    // 파일 받은 뒤 실제 이름으로 교체 필요
            case .custom(let name):
                return name
            }
        }
    }
    static func chiron(_ type: Chiron, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    // semi
    static let semiBold16: Font = .chiron(.semi, size: 16)
    static let semiBold20: Font = .chiron(.semi, size: 20)
    
    // medium
    static let medium14: Font = .chiron(.medium, size: 14)
    static let medium16: Font = .chiron(.medium, size: 16)
    
    // regular
    static let regular9: Font = .chiron(.regular, size: 9)
    static let regular12: Font = .chiron(.regular, size: 12)
    static let regular14: Font = .chiron(.regular, size: 14)
}
