//
//  OnboardingPageViewController.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 05/05/2026.
//

import UIKit
// Modules/Onboarding/View/OnboardingPageViewController


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
        delegate = self
        hideDefaultPageControl()
    }

    
    func setupPages(_ pages: [OnboardingPageModel]) {
        
        guard !pages.isEmpty else {
            print("ERROR: No pages provided to OnboardingPageViewController")
            return
        }

        contentVCs = pages.enumerated().map { index, model in
            let vc = OnboardingContentViewController()
            vc.pageIndex = index
            vc.pageModel = model
            return vc
        }

        
        guard let firstVC = contentVCs.first else { return }

        setViewControllers(
            [firstVC],
            direction: .forward,
            animated: false,
            completion: nil
        )
    }

    func scrollToPage(at index: Int, animated: Bool = true) {
     
        guard !contentVCs.isEmpty else {
            print("ERROR: contentVCs is empty")
            return
        }
        guard index >= 0, index < contentVCs.count else {
            print("ERROR: index \(index) out of range (0..<\(contentVCs.count))")
            return
        }
        guard let currentVC = viewControllers?.first as? OnboardingContentViewController else {
            print("ERROR: current VC is not OnboardingContentViewController")
            return
        }

        let direction: NavigationDirection = index > currentVC.pageIndex ? .forward : .reverse
        setViewControllers(
            [contentVCs[index]],
            direction: direction,
            animated: animated,
            completion: nil
        )
    }

    func currentIndex() -> Int {
        return (viewControllers?.first as? OnboardingContentViewController)?.pageIndex ?? 0
    }

    private func hideDefaultPageControl() {
        view.subviews
            .compactMap { $0 as? UIPageControl }
            .forEach { $0.isHidden = true }
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard
            let vc = viewController as? OnboardingContentViewController,
            vc.pageIndex > 0,
            !contentVCs.isEmpty
        else { return nil }

        return contentVCs[vc.pageIndex - 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard
            let vc = viewController as? OnboardingContentViewController,
            vc.pageIndex < contentVCs.count - 1,
            !contentVCs.isEmpty
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
