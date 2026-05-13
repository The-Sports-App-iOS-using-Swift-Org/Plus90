//
//  TeamHeaderCell.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 7/05/2026.
//

import UIKit

class TeamHeaderCell: UICollectionViewCell {

    @IBOutlet weak var teamLogoImg: UIImageView!
    @IBOutlet weak var teamNameLbl: UILabel!

    private let stadiumBgView  = UIView()
    private let patternOverlay = FootballPatternView()
    private let glowRing       = UIView()
    private let logoContainer  = UIView()
    private let nameTagView    = UIView()
    private let badgeIcon      = UIImageView()
    private let bgGradient     = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        bgGradient.frame = stadiumBgView.bounds
        glowRing.layer.cornerRadius      = glowRing.bounds.width / 2
        logoContainer.layer.cornerRadius = logoContainer.bounds.width / 2
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyThemeColors()
    }

    private func setupUI() {
        clipsToBounds = false
        backgroundColor = .clear

        stadiumBgView.translatesAutoresizingMaskIntoConstraints = false
        stadiumBgView.clipsToBounds = true
        insertSubview(stadiumBgView, at: 0)

        bgGradient.name = "bgGradient"
        stadiumBgView.layer.insertSublayer(bgGradient, at: 0)

        patternOverlay.translatesAutoresizingMaskIntoConstraints = false
        patternOverlay.alpha = 0.06
        stadiumBgView.addSubview(patternOverlay)

        glowRing.translatesAutoresizingMaskIntoConstraints = false
        stadiumBgView.addSubview(glowRing)

        logoContainer.translatesAutoresizingMaskIntoConstraints = false
        stadiumBgView.addSubview(logoContainer)

        teamLogoImg.translatesAutoresizingMaskIntoConstraints = false
        teamLogoImg.contentMode = .scaleAspectFit
        logoContainer.addSubview(teamLogoImg)

        nameTagView.translatesAutoresizingMaskIntoConstraints = false
        nameTagView.layer.cornerRadius = 14
        stadiumBgView.addSubview(nameTagView)

        badgeIcon.image = UIImage(systemName: "soccerball")
        badgeIcon.translatesAutoresizingMaskIntoConstraints = false
        nameTagView.addSubview(badgeIcon)

        teamNameLbl.translatesAutoresizingMaskIntoConstraints = false
        teamNameLbl.font = UIFont(name: "AvenirNext-Heavy", size: 20) ??
                           .systemFont(ofSize: 20, weight: .heavy)
        teamNameLbl.textAlignment = .left
        nameTagView.addSubview(teamNameLbl)

        applyThemeColors()
        setupConstraints()
    }

    private func applyThemeColors() {
        let accent = AppColors.accent
        let header = AppColors.headerBackground

        bgGradient.colors = [
            header.cgColor,
            header.withAlphaComponent(0.85).cgColor
        ]
        bgGradient.startPoint = CGPoint(x: 0, y: 0)
        bgGradient.endPoint   = CGPoint(x: 1, y: 1)

        glowRing.backgroundColor      = accent.withAlphaComponent(0.20)
        glowRing.layer.shadowColor    = accent.cgColor
        glowRing.layer.shadowRadius   = 24
        glowRing.layer.shadowOpacity  = 0.45
        glowRing.layer.shadowOffset   = .zero

        logoContainer.backgroundColor      = UIColor.white.withAlphaComponent(0.10)
        logoContainer.layer.borderWidth    = 1.5
        logoContainer.layer.borderColor    = UIColor.white.withAlphaComponent(0.35).cgColor

        nameTagView.backgroundColor      = UIColor.white.withAlphaComponent(0.12)
        nameTagView.layer.borderWidth    = 1
        nameTagView.layer.borderColor    = UIColor.white.withAlphaComponent(0.20).cgColor

        teamNameLbl.textColor = AppColors.headerText
        badgeIcon.tintColor   = AppColors.headerText
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stadiumBgView.topAnchor.constraint(equalTo: topAnchor),
            stadiumBgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stadiumBgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stadiumBgView.bottomAnchor.constraint(equalTo: bottomAnchor),

            patternOverlay.topAnchor.constraint(equalTo: stadiumBgView.topAnchor),
            patternOverlay.leadingAnchor.constraint(equalTo: stadiumBgView.leadingAnchor),
            patternOverlay.trailingAnchor.constraint(equalTo: stadiumBgView.trailingAnchor),
            patternOverlay.bottomAnchor.constraint(equalTo: stadiumBgView.bottomAnchor),

            glowRing.centerXAnchor.constraint(equalTo: stadiumBgView.centerXAnchor),
            glowRing.centerYAnchor.constraint(equalTo: stadiumBgView.centerYAnchor, constant: -20),
            glowRing.widthAnchor.constraint(equalToConstant: 110),
            glowRing.heightAnchor.constraint(equalToConstant: 110),

            logoContainer.centerXAnchor.constraint(equalTo: stadiumBgView.centerXAnchor),
            logoContainer.centerYAnchor.constraint(equalTo: stadiumBgView.centerYAnchor, constant: -20),
            logoContainer.widthAnchor.constraint(equalToConstant: 90),
            logoContainer.heightAnchor.constraint(equalToConstant: 90),

            teamLogoImg.topAnchor.constraint(equalTo: logoContainer.topAnchor, constant: 8),
            teamLogoImg.leadingAnchor.constraint(equalTo: logoContainer.leadingAnchor, constant: 8),
            teamLogoImg.trailingAnchor.constraint(equalTo: logoContainer.trailingAnchor, constant: -8),
            teamLogoImg.bottomAnchor.constraint(equalTo: logoContainer.bottomAnchor, constant: -8),

            nameTagView.centerXAnchor.constraint(equalTo: stadiumBgView.centerXAnchor),
            nameTagView.topAnchor.constraint(equalTo: logoContainer.bottomAnchor, constant: 16),
            nameTagView.heightAnchor.constraint(equalToConstant: 36),

            badgeIcon.leadingAnchor.constraint(equalTo: nameTagView.leadingAnchor, constant: 12),
            badgeIcon.centerYAnchor.constraint(equalTo: nameTagView.centerYAnchor),
            badgeIcon.widthAnchor.constraint(equalToConstant: 16),
            badgeIcon.heightAnchor.constraint(equalToConstant: 16),

            teamNameLbl.leadingAnchor.constraint(equalTo: badgeIcon.trailingAnchor, constant: 8),
            teamNameLbl.trailingAnchor.constraint(equalTo: nameTagView.trailingAnchor, constant: -14),
            teamNameLbl.centerYAnchor.constraint(equalTo: nameTagView.centerYAnchor)
        ])
    }

    func configure(name: String?, logoUrl: String?) {
        teamNameLbl.text = name ?? "Unknown Team"
        if let url = logoUrl {
            teamLogoImg.loadImage(from: url, placeholder: UIImage(named: "team_placeholder"))
        }
        logoContainer.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        logoContainer.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0.1,
                       usingSpringWithDamping: 0.65, initialSpringVelocity: 0.5) {
            self.logoContainer.transform = .identity
            self.logoContainer.alpha = 1
        }
        nameTagView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.35) {
            self.nameTagView.alpha = 1
        }
    }
}

private class FootballPatternView: UIView {
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setLineWidth(18)
        var x: CGFloat = -40
        while x < rect.width + 40 {
            ctx.move(to: CGPoint(x: x, y: 0))
            ctx.addLine(to: CGPoint(x: x, y: rect.height))
            x += 40
        }
        ctx.strokePath()
    }
}
