//
//  SportsViewController.swift
//  Plus90-Swift
//
//  Created by Nemo on 06/05/2026.
//

import UIKit

class SportsViewController: UIViewController {
    @IBOutlet weak var headerSportsView: UIView!
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    private let themeToggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        return button
    }()
    
    var presenter: SportsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SportsPresenter()
        presenter?.attachView(self)
        
        applySavedThemeToWindow()
        applyTheme()
        headerSportsViewDecoration()
        setupCollectionView()
        setupThemeButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        let isDark = UserDefaults.standard.bool(forKey: "isDarkMode")
        applySavedThemeToWindow()
        updateButtonIcon(isDark: isDark)
    }


    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        applyTheme()
    }

    private func applyTheme() {
        view.backgroundColor = AppColors.primaryBackground
        headerSportsView.backgroundColor = AppColors.headerBackground
        sportsCollectionView.backgroundColor = AppColors.primaryBackground
    }
    
    private func setupThemeButton() {
        headerSportsView.addSubview(themeToggleButton)
    
        themeToggleButton.addTarget(self, action: #selector(handleThemeToggle), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            themeToggleButton.trailingAnchor.constraint(equalTo: headerSportsView.trailingAnchor, constant: -20),
            themeToggleButton.centerYAnchor.constraint(equalTo: headerSportsView.centerYAnchor, constant: 10),
            themeToggleButton.widthAnchor.constraint(equalToConstant: 44),
            themeToggleButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func updateButtonIcon(isDark: Bool) {
        let imageName = isDark ? "sun.max.fill" : "moon.fill"
        themeToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private func applySavedThemeToWindow() {
        let isDark = UserDefaults.standard.bool(forKey: "isDarkMode")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        window.overrideUserInterfaceStyle = isDark ? .dark : .light
    }
    
    @objc private func handleThemeToggle() {
        let currentIsDark = UserDefaults.standard.bool(forKey: "isDarkMode")
        let newIsDark = !currentIsDark
        UserDefaults.standard.set(newIsDark, forKey: "isDarkMode")
        updateButtonIcon(isDark: newIsDark)

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.overrideUserInterfaceStyle = newIsDark ? .dark : .light
        }, completion: nil)
    }
    
    func headerSportsViewDecoration() {
        headerSportsView.layer.cornerRadius = 40
        headerSportsView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    func setupCollectionView() {
        sportsCollectionView.dataSource = self
        sportsCollectionView.delegate = self
        let nib = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        sportsCollectionView.register(nib, forCellWithReuseIdentifier: "SportsCell")
    }
}


extension SportsViewController: SportsViewProtocol {
    func startAnimating() {}
    func stopAnimating() {}
    func reloadCollection() {
        sportsCollectionView.reloadData()
    }
}

extension SportsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getSportsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesVC") as! LeaguesViewController
        if let sport = presenter?.getSport(at: indexPath.row) {
            leaguesVC.selectedSportName = sport.name
        }
        leaguesVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(leaguesVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportsCollectionViewCell
        if let sport = presenter?.getSport(at: indexPath.row) {
            cell.configure(name: sport.name, image: sport.image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - 45
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: itemWidth + 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
}
