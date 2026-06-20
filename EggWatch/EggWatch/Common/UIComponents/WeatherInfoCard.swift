import SwiftUI

struct WeatherInfoCard: View {
    let weather: WeatherInfo
    var outingElapsedSeconds: Int? = nil

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                Text(weather.location)
                    .font(.medium16)
                    .foregroundStyle(Color.black)
                HStack(alignment: .center, spacing: 10) {
                    Text("\(weather.temperature)º")
                        .font(.semiBold20)
                        .foregroundStyle(.black)
                    Text(weather.condition)
                        .font(.regular12)
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                Text("자외선 지수")
                    .font(.medium16)
                    .foregroundStyle(Color.black)
                HStack(alignment: .center, spacing: 10) {
                    Text("\(weather.uvIndex)")
                        .font(.semiBold20)
                        .foregroundStyle(.black)
                    Text(weather.uvLevel.rawValue)
                        .font(.regular12)
                        .foregroundStyle(.black)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            if let seconds = outingElapsedSeconds {
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text("외출 시간")
                        .font(.medium16)
                        .foregroundStyle(Color.black)
                    Text(formattedOutingTime(seconds))
                        .font(.semiBold20)
                        .foregroundStyle(.black)
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
            }
        }
        .padding(.vertical, 28)
    }

    private func formattedOutingTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }
}
