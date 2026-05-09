//
//  SplashViewController.swift
//  Plus90-Swift
//
//  Created by Nemo on 08/05/2026.
//

import UIKit
import SDWebImage

class SplashViewController: UIViewController {

    @IBOutlet weak var plus90Subtitle: UILabel!
    @IBOutlet weak var plus90Title: UILabel!
    @IBOutlet weak var splashImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGIF()
        startSplashFlow()
    }
    private func setupGIF() {
        guard let url = Bundle.main.url(forResource: "splashh", withExtension: "gif") else {
            return
        }
        splashImage.sd_setImage(with: url)
    }
    private func startSplashFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.routeAfterSplash()
        }
    }

    private func routeAfterSplash() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let nextVC: UIViewController

        if OnboardingPresenter.hasSeenOnboarding() {
            nextVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        } else {
            nextVC = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
        }

        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }

        sceneDelegate.window?.rootViewController = nextVC
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
