//
//  OnboardingViewController.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 05/05/2026.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    private var presenter: OnboardingPresenter!

    private var pageVC: OnboardingPageViewController?

    private let appGreen: UIColor = UIColor(named: "AppGreen") ?? .systemGreen

    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = appGreen
        pc.pageIndicatorTintColor        = .systemGray4
        pc.isUserInteractionEnabled      = false
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    private lazy var actionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        btn.backgroundColor  = appGreen
        btn.layer.cornerRadius = 14
        btn.clipsToBounds    = true
        btn.addTarget(
            self,
            action: #selector(actionButtonTapped),
            for: .touchUpInside
        )
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private lazy var skipButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Skip", for: .normal)
        btn.setTitleColor(.systemGray, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15)
        btn.addTarget(
            self,
            action: #selector(skipButtonTapped),
            for: .touchUpInside
        )
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()


    private var containerView: UIView? {
        return view.subviews.first(where: { !($0 is UIButton) && !($0 is UIPageControl) })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter = OnboardingPresenter(view: self)
    }


    private var didSetupUI = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !didSetupUI else { return }
        didSetupUI = true
        setupProgrammaticUI()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedPageVC",
           let pageVC = segue.destination as? OnboardingPageViewController {
            self.pageVC       = pageVC
            pageVC.pageDelegate = self
            pageVC.setupPages(presenter.pages)
        }
    }

    private func setupProgrammaticUI() {
        guard let container = view.subviews.first(where: {
            // The container view added by storyboard embed
            String(describing: type(of: $0)) != "UIButton" &&
            String(describing: type(of: $0)) != "UIPageControl"
        }) else { return }

        view.addSubview(pageControl)
        view.addSubview(actionButton)
        view.addSubview(skipButton)

        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(
                equalTo: container.bottomAnchor,
                constant: 16
            ),
            pageControl.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            actionButton.topAnchor.constraint(
                equalTo: pageControl.bottomAnchor,
                constant: 20
            ),
            actionButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 30
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -30
            ),
            actionButton.heightAnchor.constraint(equalToConstant: 52),


            skipButton.topAnchor.constraint(
                equalTo: actionButton.bottomAnchor,
                constant: 14
            ),
            skipButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            skipButton.bottomAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            )
        ])


        pageControl.numberOfPages = presenter.pages.count
        pageControl.currentPage   = 0
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
            self.actionButton.setTitle(
                isLastPage ? "Get Started" : "Next",
                for: .normal
            )
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
        print("Navigation To MainTabBar")
        /*let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        tabBar.modalTransitionStyle   = .crossDissolve
        present(tabBar, animated: true)*/
    }
}

extension OnboardingViewController: OnboardingPageViewControllerDelegate {

    func didSwipeToPage(index: Int) {
        presenter.didChangePage(to: index)
    }
}
