
import Foundation

// MARK: - Weather
struct Weather: Codable {
    let result: [Result]
}

// MARK: - Result
struct Result: Codable {
    let date, day: String
    let icon: String
    let description, status, degree, min: String
    let max, night, humidity: String
}

