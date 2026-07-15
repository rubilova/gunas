import SwiftUI

enum GunaColors {
    static let sattva = Color(hex: "2E9E86")
    static let sattvaSoft = Color(hex: "E4F5F0")
    static let rajas = Color(hex: "D9702E")
    static let rajasSoft = Color(hex: "FBEAE0")
    static let tamas = Color(hex: "5B5470")
    static let tamasSoft = Color(hex: "EAE8EF")
    static let ink = Color(hex: "1F1D2B")
    static let muted = Color(hex: "8A8797")
    static let background = Color(hex: "FAF9F7")
    static let card = Color.white
    static let border = Color(hex: "E3E0DA")

    static func color(for guna: Guna) -> Color {
        switch guna {
        case .sattva: return sattva
        case .rajas: return rajas
        case .tamas: return tamas
        }
    }

    static func softColor(for guna: Guna) -> Color {
        switch guna {
        case .sattva: return sattvaSoft
        case .rajas: return rajasSoft
        case .tamas: return tamasSoft
        }
    }
}

extension Color {
    init(hex: String) {
        var hexValue = UInt64()
        Scanner(string: hex).scanHexInt64(&hexValue)
        let r = Double((hexValue & 0xFF0000) >> 16) / 255
        let g = Double((hexValue & 0x00FF00) >> 8) / 255
        let b = Double(hexValue & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
