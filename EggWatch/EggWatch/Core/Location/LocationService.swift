//
//  LocationService.swift
//  EggWatch
//
//  Created by JOON on 6/18/26.
//
// 현재 위치(위도/경도)를 가져오는 서비스

import Foundation
import CoreLocation
import Combine

// MARK: - 위치 서비스
class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()

    @Published var latitude: Double = 0.0   // 현재 위도
    @Published var longitude: Double = 0.0  // 현재 경도
    @Published var isAuthorized: Bool = false  // 위치 권한 허용 여부

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  // 가장 정확한 위치
        requestPermission()  // 앱 시작 시 권한 요청
    }

    // MARK: - 위치 권한 요청
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()  // 앱 사용 중 위치 권한 요청
    }

    // MARK: - 현재 위치 한 번만 가져오기
    func fetchOnce() {
        locationManager.requestLocation()  // 위치 한 번만 요청
    }

    // MARK: - 위치 업데이트 성공 시 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.latitude = location.coordinate.latitude   // 위도 저장
            self.longitude = location.coordinate.longitude // 경도 저장
        }
    }

    // MARK: - 위치 권한 상태 변경 시 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            isAuthorized = true
            fetchOnce()     // 권한 허용되는 순간 바로 위치 가져오기
        default:
            isAuthorized = false
        }
    }

    // MARK: - 위치 가져오기 실패 시 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 가져오기 실패: \(error)")
    }
}
