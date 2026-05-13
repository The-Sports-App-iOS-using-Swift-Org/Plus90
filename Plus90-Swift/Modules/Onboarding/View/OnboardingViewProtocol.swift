//
//  OnboardingViewProtocol.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 12/05/2026.
//


struct OnboardingPageModel {
    let imageName: String
    let title: String
    let subtitle: String
}


protocol OnboardingViewProtocol: AnyObject {
    func updatePageControl(currentIndex: Int)
    func updateActionButton(isLastPage: Bool)
    func scrollToNextPage()
    func navigateToMainApp()
}
