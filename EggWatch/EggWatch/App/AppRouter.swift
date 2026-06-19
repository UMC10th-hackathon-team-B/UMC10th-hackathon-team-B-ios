import SwiftUI
import Combine

enum AppScreen {
    case splash
    case agreement
    case home
    case uvSelection
    case outing
    case outingEndConfirm
    case alert
}

class AppRouter: ObservableObject {
    @Published var currentScreen: AppScreen
    private var previousScreen: AppScreen = .home
    init(initialScreen: AppScreen = .home) {
            self.currentScreen = initialScreen
        }

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
    func goToOutingEndConfirm() {
        currentScreen = .outingEndConfirm
    }
    func goToAlert() {
        previousScreen = currentScreen
        currentScreen = .alert
    }
    func goBack() {
        currentScreen = previousScreen
    }
    func goToSplash() {
        currentScreen = .splash
    }
}
