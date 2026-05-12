//
//  SettingsViewController.swift
//  Plus90-Swift
//
//  Created by Nemo on 12/05/2026.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var themeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isDark = UserDefaults.standard.bool(forKey: "isDarkMode")
        themeSwitch.isOn = isDark
        themeSwitch.onTintColor = AppColors.accent
    }
    
    @IBAction func toggleButton(_ sender: UISwitch) {
        let isDark = sender.isOn
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        UIView.animate(withDuration: 0.3) {
            window.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
        
        UserDefaults.standard.set(isDark, forKey: "isDarkMode")
    }
}
