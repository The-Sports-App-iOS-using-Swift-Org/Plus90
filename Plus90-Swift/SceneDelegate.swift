//
//  SceneDelegate.swift
//  Plus90-Swift
//
//  Created by Nemo on 05/05/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        if OnboardingPresenter.hasSeenOnboarding() {
            print("Showing MainTabBarController After Showing Onboaridng once in SceneDelegate")
          //  window?.rootViewController = MainTabBarController()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let onboardingVC = storyboard.instantiateViewController(
                withIdentifier: "OnboardingViewController"
            ) as! OnboardingViewController
            window?.rootViewController = onboardingVC

        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let onboardingVC = storyboard.instantiateViewController(
                withIdentifier: "OnboardingViewController"
            ) as! OnboardingViewController
            window?.rootViewController = onboardingVC
        }
        
        window?.makeKeyAndVisible()
    }
    private func makeOnboardingVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let onboardingVC = storyboard.instantiateViewController(
            withIdentifier: "OnboardingViewController"
        ) as? OnboardingViewController else {
            print("ERROR: Could not find 'OnboardingViewController' in Main.storyboard")
            print("Check: Storyboard ID is set to 'OnboardingViewController'")
            return UIViewController()
        }

        return onboardingVC
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
