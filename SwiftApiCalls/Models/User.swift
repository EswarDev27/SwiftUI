import Foundation

// MARK: - Model
struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let email: String
}
