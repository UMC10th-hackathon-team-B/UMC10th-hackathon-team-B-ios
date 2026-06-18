/*
import Foundation
import CoreLocation

class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var weather: WeatherInfo = .placeholder  // 기본값
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let weatherService = WeatherService()
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // 위치 받으면 자동으로 날씨 호출
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()  // 한 번만 받기

        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        fetchWeather(lat: lat, lon: lon)
    }

    // 날씨 API 호출
    func fetchWeather(lat: Double, lon: Double) {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let result = try await weatherService.fetchWeather(lat: lat, lon: lon)
                await MainActor.run {
                    self.weather = result
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "날씨 정보를 불러올 수 없어요."
                    self.isLoading = false
                }
            }
        }
    }
}
*/
