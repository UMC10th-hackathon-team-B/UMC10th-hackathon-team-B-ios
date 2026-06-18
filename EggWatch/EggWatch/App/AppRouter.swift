import SwiftUI
import Combine

enum AppScreen {
    case splash
    case agreement
    case home
    case uvSelection
    case outing
}

class AppRouter: ObservableObject {
    @Published var currentScreen: AppScreen = .splash
    @Published var showAlert: Bool = false

    func goToAgreement() {
        currentScreen = .agreement
    }
    func goToHome() {
        currentScreen = .home
    }
    func goToUVSelection() {
        currentScreen = .uvSelection
    }
    func goToOuting() {
        currentScreen = .outing
    }
    func goToSplash() {
        currentScreen = .splash
    }
}
