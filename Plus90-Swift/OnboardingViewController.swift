//
//  OnboardingViewController.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 05/05/2026.
//


import UIKit
// Modules/Onboarding/View/OnboardingViewController

class OnboardingViewController: UIViewController {

    private lazy var presenter: OnboardingPresenter = {
        OnboardingPresenter(view: self)
    }()

    private var pageVC: OnboardingPageViewController?

    private let appGreen: UIColor = UIColor(named: "AppGreen") ?? UIColor(
        red: 52/255, green: 199/255, blue: 89/255, alpha: 1
    )


    private lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = appGreen
        pc.pageIndicatorTintColor = .systemGray4
        pc.isUserInteractionEnabled = false
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    private lazy var actionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Get Started", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        btn.backgroundColor = appGreen
        btn.layer.cornerRadius = 14
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private lazy var skipButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Skip", for: .normal)
        btn.setTitleColor(.systemGray, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        embedPageViewController()
    }

    private func setupLayout() {
        view.addSubview(containerView)
        view.addSubview(pageControl)
        view.addSubview(actionButton)
        view.addSubview(skipButton)

        pageControl.numberOfPages = presenter.pages.count
        pageControl.currentPage = 0

        updateActionButton(isLastPage: presenter.pages.count == 1)

        NSLayoutConstraint.activate([

            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.72),

            pageControl.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            actionButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            actionButton.heightAnchor.constraint(equalToConstant: 52),

            skipButton.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 14),
            skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            skipButton.bottomAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            )
        ])
    }

    private func embedPageViewController() {
        let pvc = OnboardingPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        pvc.pageDelegate = self
        pvc.setupPages(presenter.pages)

        self.pageVC = pvc

        addChild(pvc)
        containerView.addSubview(pvc.view)
        pvc.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pvc.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            pvc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pvc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            pvc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        pvc.didMove(toParent: self)
    }

    @objc private func actionButtonTapped() {
        presenter.didTapActionButton()
    }

    @objc private func skipButtonTapped() {
        presenter.didTapSkip()
    }
}

extension OnboardingViewController: OnboardingViewProtocol {

    func updatePageControl(currentIndex: Int) {
        pageControl.currentPage = currentIndex
    }

    func updateActionButton(isLastPage: Bool) {
        UIView.transition(
            with: actionButton,
            duration: 0.25,
            options: .transitionCrossDissolve
        ) {
            self.actionButton.setTitle(isLastPage ? "Get Started" : "Next", for: .normal)
        }
        UIView.animate(withDuration: 0.25) {
            self.skipButton.alpha = isLastPage ? 0 : 1
        } completion: { _ in
            self.skipButton.isHidden = isLastPage
        }
    }

    func scrollToNextPage() {
        pageVC?.scrollToPage(at: presenter.currentIndex)
    }

    func navigateToMainApp() {        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBar = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        
        guard let window = self.view.window else { return }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = mainTabBar
        }, completion: nil)
    }
}

extension OnboardingViewController: OnboardingPageViewControllerDelegate {
    func didSwipeToPage(index: Int) {
        presenter.didChangePage(to: index)
    }
}
