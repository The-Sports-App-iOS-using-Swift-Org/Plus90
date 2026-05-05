//
//  OnboardingContentViewController.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 05/05/2026.
//

import UIKit

class OnboardingContentViewController: UIViewController {

    var pageIndex: Int = 0
    var pageModel: OnboardingPageModel?

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 24
        iv.backgroundColor = .secondarySystemBackground
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 26)
        lbl.textColor = .label
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textColor = .secondaryLabel
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configure()
    }

    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 30
            ),
            imageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            imageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            imageView.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: 0.60
            ),

            
            titleLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: 30
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),

            
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 14
            ),
            subtitleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 30
            ),
            subtitleLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -30
            ),
            subtitleLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: view.bottomAnchor,
                constant: -20
            )
        ])
    }

    
    private func configure() {
        guard let model = pageModel else { return }
        titleLabel.text    = model.title
        subtitleLabel.text = model.subtitle
        imageView.image    = UIImage(named: model.imageName)
    }
}
