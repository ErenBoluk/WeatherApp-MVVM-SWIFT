import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


enum AppColor {
    case base
    case secondary
    case firstGradient
    case secondGradient
    
    var color: UIColor {
        let night = !isNightTime()
        switch self {
        case .base:
            return night ? UIColor(hex: "#FFFFFF") : UIColor(hex: "#303345")
        case .secondary:
            return night ? UIColor(hex: "#EEEEEE") : UIColor(hex: "#9A938C")
        case .firstGradient:
            return night ? UIColor(hex: "#2249AB") : UIColor(hex: "#FEE2C6")
        case .secondGradient:
            return night ? UIColor(hex: "#01113A") : UIColor(hex: "#FEBD8B")
        }
        
    }
}
func isNightTime() -> Bool {
    let calendar = Calendar.current
    let currentDate = Date()
    let hour = calendar.component(.hour, from: currentDate)
    
    return hour >= 18 || hour < 6 // Eğer saat 18'den büyük veya 6'dan küçükse gece kabul edilir
}
