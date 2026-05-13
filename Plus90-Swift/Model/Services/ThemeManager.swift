//
//  ThemeManager.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 13/05/2026.
//

import UIKit

class ThemeManager {
    
    static func applyTheme(isDark: Bool, window: UIWindow?) {
        guard let window = window else { return }
        
        window.overrideUserInterfaceStyle = isDark ? .dark : .light
        applyTabBarTheme(isDark: isDark)
    }
    
    static func applyTabBarTheme(isDark: Bool) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Background color
        appearance.backgroundColor = isDark ? UIColor(hex: "#1C1C1E") : UIColor(hex: "#FFFFFF")
        
        // Selected item color
        let selectedColor = isDark ? UIColor(hex: "#FF6B00") : UIColor(hex: "#FF6B00") // your app's accent
        
        // Unselected item color
        let unselectedColor = isDark ? UIColor(hex: "#8E8E93") : UIColor(hex: "#8E8E93")
        
        // Icon colors
        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
        
        // Title colors
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedColor]
        
        // Apply globally
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // Force refresh all existing tab bars
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .forEach { window in
                window.rootViewController?.findTabBarController()?.tabBar.setNeedsLayout()
                window.rootViewController?.findTabBarController()?.tabBar.layoutIfNeeded()
            }
    }
}


// MARK: - Find TabBarController helper
extension UIViewController {
    func findTabBarController() -> UITabBarController? {
        if let tab = self as? UITabBarController { return tab }
        for child in children {
            if let tab = child.findTabBarController() { return tab }
        }
        return nil
    }
}
