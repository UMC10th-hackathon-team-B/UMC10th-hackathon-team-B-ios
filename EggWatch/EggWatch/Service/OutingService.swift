//
//  OutingService.swift
//  EggWatch
//
//  Created by 최윤석 on 6/20/26.
//
//  외출 도메인 API 4개(시작/조회/선크림/종료)를 호출하는 서비스

import Foundation
import Moya

// MARK: - 외출 서비스
class OutingService {

    // MARK: - Moya Provider
    // AuthPlugin: accessToken 헤더 자동 첨부
    // TokenRefreshPlugin: 401 시 자동 재발급
    private let provider = MoyaProvider<OutingRouter>(plugins: [
        AuthPlugin(),
        TokenRefreshPlugin()
    ])
}
