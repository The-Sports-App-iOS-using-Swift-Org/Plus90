//
//  AppColors.swift
//  Plus90-Swift
//
//  Created by Nemo on 12/05/2026.
//

import UIKit

struct AppColors {

    static var accent: UIColor {
        return UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(hex: "#01632A")
            : UIColor(hex: "#008337")
        }
    }

    static var primaryBackground: UIColor {
        return UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(hex: "#121212")
            : UIColor(hex: "#FFFFFF")
        }
    }

    static var secondaryBackground: UIColor {
        return UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(hex: "#1E1E1E")
            : UIColor(hex: "#F5F5F5")
        }
    }

    static var cardBackground: UIColor {
        return UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(hex: "#2A2A2A")
            : UIColor(hex: "#FFFFFF")
        }
    }

    static var headerBackground: UIColor {
        return UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(hex: "#01632A")
            : UIColor(hex: "#008337")
        }
    }

    // MARK: - Text
    static var primaryText: UIColor {
        return UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(hex: "#FFFFFF")
            : UIColor(hex: "#333333")
        }
    }

    static var secondaryText: UIColor {
        return UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(hex: "#AAAAAA")
            : UIColor(hex: "#888888")
        }
    }

    static var headerText: UIColor {
        return UIColor(hex: "#FFFFFF")  // always white on green header
    }

    // MARK: - Status
    static var liveBadge: UIColor {
        return UIColor(hex: "#E63946")  // always red
    }

    static var finishedBadge: UIColor {
        return UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(hex: "#30D158")
            : UIColor(hex: "#4CAF50")
        }
    }

    static var separator: UIColor {
        return UIColor { trait in
            trait.userInterfaceStyle == .dark
            ? UIColor(hex: "#3A3A3A")
            : UIColor(hex: "#E0E0E0")
        }
    }
}

// MARK: - UIColor hex init
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8)  / 255.0
        let b = CGFloat(rgb & 0x0000FF)          / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
