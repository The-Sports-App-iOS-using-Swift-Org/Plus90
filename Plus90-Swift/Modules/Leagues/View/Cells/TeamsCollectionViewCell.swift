//
//  TeamsCollectionViewCell.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 09/05/2026.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        applyTheme()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.width / 2
        teamLogoImageView.clipsToBounds = true
    }
    private func setupUI() {
        teamLogoImageView.contentMode = .scaleAspectFill
        teamLogoImageView.clipsToBounds = true
        teamLogoImageView.layer.borderWidth = 2.0
        applyTheme()
    }
    private func applyTheme() {
        teamNameLabel.textColor = AppColors.primaryText
        teamLogoImageView.layer.borderColor = AppColors.separator.cgColor
    }
    func configure(with team: Team) {
        teamNameLabel.text = team.teamName
        if let logoUrl = team.teamLogo {
            teamLogoImageView.loadImage(from: logoUrl, placeholder: UIImage(named: "placeholder"))
        }
    }
}
