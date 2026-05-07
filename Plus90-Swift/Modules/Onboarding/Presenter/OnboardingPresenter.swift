//
//  OnboardingPresenter.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 05/05/2026.
//

import Foundation
// Modules/Onboarding/Presenter/OnboardingPresenter

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


class OnboardingPresenter {

    weak var view: OnboardingViewProtocol?
    private(set) var currentIndex: Int = 0

    let pages: [OnboardingPageModel] = [
        OnboardingPageModel(
            imageName: "onboarding1",
            title: "Welcome to Plus90",
            subtitle: "Your ultimate destination for live scores,\nscout reports, and elite performance tracking."
        ),
        OnboardingPageModel(
            imageName: "onboarding2",
            title: "Track Every League",
            subtitle: "Follow your favourite leagues and get\nreal-time updates instantly."
        ),
       OnboardingPageModel(
           imageName: "onboarding3",
           title: "Your Favourites, Always Ready",
           subtitle: "Save leagues and access them anytime,\neven offline."
       )
       
    ]

    init(view: OnboardingViewProtocol) {
        self.view = view
    }

    func didChangePage(to index: Int) {
        guard index >= 0, index < pages.count else { return }
        currentIndex = index
        view?.updatePageControl(currentIndex: index)
        view?.updateActionButton(isLastPage: isLastPage)
    }

    func didTapActionButton() {
        if isLastPage {
            markOnboardingAsSeen()
            view?.navigateToMainApp()
        } else {
            currentIndex += 1
            view?.updatePageControl(currentIndex: currentIndex)
            view?.updateActionButton(isLastPage: isLastPage)
            view?.scrollToNextPage()
        }
    }

    func didTapSkip() {
        markOnboardingAsSeen()
        view?.navigateToMainApp()
    }

    static func hasSeenOnboarding() -> Bool {
        return UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    }

    private var isLastPage: Bool {
        return currentIndex == pages.count - 1
    }

    private func markOnboardingAsSeen() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
    }
}
