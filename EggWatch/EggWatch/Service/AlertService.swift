//
//  AlertService.swift
//  EggWatch
//
//  Created by JOON on 6/17/26.
//
//  알림함 조회/읽음 처리 API를 호출하는 서비스

import Foundation
import Moya

// MARK: - 알림 서비스
class AlertService {

    // MARK: - Moya Provider
    // AuthPlugin: accessToken 헤더 자동 첨부
    // TokenRefreshPlugin: 401 시 자동 재발급
    private let provider = MoyaProvider<NotificationRouter>(plugins: [
        AuthPlugin(),
        TokenRefreshPlugin()
    ])
}
