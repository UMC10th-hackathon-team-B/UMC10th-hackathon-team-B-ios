import SwiftUI

struct WeatherInfoCard: View {
    let weather: WeatherInfo
    
    var body: some View {
        HStack(spacing: 100) {
            VStack(alignment: .leading, spacing: 6) {
                Text(weather.location)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.black)
                HStack(alignment: .lastTextBaseline, spacing: 6) {
                    Text("\(weather.temperature)º")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.black)
                    Text(weather.condition)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.gray)
                }
            }
            VStack(alignment: .leading, spacing: 6) {
                Text("자외선 지수")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.black)
                HStack(alignment: .lastTextBaseline, spacing: 6) {
                    Text("\(weather.uvIndex)")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.black)
                    Text(weather.uvLevel.rawValue)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
    }
}
