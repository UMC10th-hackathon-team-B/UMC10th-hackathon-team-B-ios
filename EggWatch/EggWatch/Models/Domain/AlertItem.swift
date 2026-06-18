import Foundation

struct AlertItem: Identifiable {
    let id: UUID = UUID()
    let title: String
    let message: String
    let time: String
}
