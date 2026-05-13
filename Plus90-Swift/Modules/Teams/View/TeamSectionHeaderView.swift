//
//  TeamSectionHeaderView.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 7/05/2026.
//

import UIKit

class TeamSectionHeaderView: UICollectionReusableView {

    private let titleLabel    = UILabel()
    private let accentBar     = UIView()
    private let separatorLine = GradientLineView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        applyBackground()

        accentBar.backgroundColor = AppColors.accent
        accentBar.layer.cornerRadius = 2
        accentBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(accentBar)

        titleLabel.font = UIFont(name: "AvenirNext-Heavy", size: 15) ??
                          .systemFont(ofSize: 15, weight: .heavy)
        titleLabel.textColor = AppColors.primaryText
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorLine)

        NSLayoutConstraint.activate([
            accentBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            accentBar.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -4),
            accentBar.widthAnchor.constraint(equalToConstant: 4),
            accentBar.heightAnchor.constraint(equalToConstant: 18),

            titleLabel.leadingAnchor.constraint(equalTo: accentBar.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: accentBar.centerYAnchor),

            separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separatorLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }


    private func applyBackground() {
        if traitCollection.userInterfaceStyle == .dark {
            backgroundColor = UIColor(red: 0.06, green: 0.09, blue: 0.07, alpha: 1)
        } else {
            backgroundColor = AppColors.primaryBackground
        }
    }

    func configure(title: String) {
        let attributed = NSAttributedString(
            string: title.uppercased(),
            attributes: [.kern: CGFloat(1.5)]
        )
        titleLabel.attributedText = attributed
        accentBar.isHidden        = title.isEmpty
        separatorLine.isHidden    = title.isEmpty
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        applyBackground()
        accentBar.backgroundColor = AppColors.accent
        titleLabel.textColor      = AppColors.primaryText
        separatorLine.refreshColors()
    }
}

private class GradientLineView: UIView {
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(gradientLayer)
        refreshColors()
    }
    required init?(coder: NSCoder) { fatalError() }

    func refreshColors() {
        let accent = AppColors.accent
        gradientLayer.colors = [
            accent.cgColor,
            accent.withAlphaComponent(0.3).cgColor,
            UIColor.clear.cgColor
        ]
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        refreshColors()
    }
}
