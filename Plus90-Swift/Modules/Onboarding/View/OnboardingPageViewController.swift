//
//  OnboardingPageViewController.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 05/05/2026.
//

import UIKit

protocol OnboardingPageViewControllerDelegate: AnyObject {
    func didSwipeToPage(index: Int)
}

class OnboardingPageViewController: UIPageViewController {

    weak var pageDelegate: OnboardingPageViewControllerDelegate?
    private var contentVCs: [OnboardingContentViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        dataSource = self
        delegate   = self
        hideDefaultPageControl()
    }

    func setupPages(_ pages: [OnboardingPageModel]) {

        contentVCs = pages.enumerated().map { index, model in
            let vc          = OnboardingContentViewController()
            vc.pageIndex    = index
            vc.pageModel    = model
            return vc
        }

        guard let firstVC = contentVCs.first else { return }
        setViewControllers(
            [firstVC],
            direction: .forward,
            animated: false
        )
    }

    func scrollToPage(at index: Int, animated: Bool = true) {
        guard
            index >= 0,
            index < contentVCs.count,
            let currentVC = viewControllers?.first as? OnboardingContentViewController
        else { return }

        let direction: NavigationDirection = index > currentVC.pageIndex
            ? .forward
            : .reverse

        setViewControllers(
            [contentVCs[index]],
            direction: direction,
            animated: animated
        )
    }

    func currentIndex() -> Int {
        return (viewControllers?.first as? OnboardingContentViewController)?.pageIndex ?? 0
    }

    // MARK: - Hide default UIPageControl dots
    private func hideDefaultPageControl() {
        view.subviews
            .compactMap { \$0 as? UIPageControl }
            .forEach { \$0.isHidden = true }
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard
            let vc = viewController as? OnboardingContentViewController,
            vc.pageIndex > 0
        else { return nil }
        return contentVCs[vc.pageIndex - 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard
            let vc = viewController as? OnboardingContentViewController,
            vc.pageIndex < contentVCs.count - 1
        else { return nil }
        return contentVCs[vc.pageIndex + 1]
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard
            completed,
            let current = pageViewController.viewControllers?.first
                as? OnboardingContentViewController
        else { return }

        pageDelegate?.didSwipeToPage(index: current.pageIndex)
    }
}
