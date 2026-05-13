//
//  UpcomingCollectionViewCell.swift
//  Plus90-Swift
//
//  Created by Nemo on 08/05/2026.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var team2Image: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

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
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 16).cgPath
        team1Image.layer.cornerRadius = team1Image.frame.width / 2
        team2Image.layer.cornerRadius = team2Image.frame.width / 2
    }

    private func setupUI() {
        layer.cornerRadius = 16
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 12
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        team1Image.contentMode = .scaleAspectFit
        team1Image.clipsToBounds = true
        team2Image.contentMode = .scaleAspectFit
        team2Image.clipsToBounds = true
        team1Name.font = .systemFont(ofSize: 14, weight: .semibold)
        team1Name.textAlignment = .center
        team1Name.numberOfLines = 2
        team2Name.font = .systemFont(ofSize: 14, weight: .semibold)
        team2Name.textAlignment = .center
        team2Name.numberOfLines = 2
        dateLabel.font = .systemFont(ofSize: 13)
        applyTheme()
    }

    private func applyTheme() {
        contentView.backgroundColor = AppColors.cardBackground
        contentView.layer.borderColor = AppColors.separator.cgColor
        team1Name.textColor = AppColors.primaryText
        team2Name.textColor = AppColors.primaryText
        dateLabel.textColor = AppColors.secondaryText
    }

    func configure(with match: MatchEvent) {
        team1Name.text = match.eventHomeTeam
        team2Name.text = match.eventAwayTeam
        let date = match.eventDate ?? ""
        let time = match.eventTime ?? ""
        dateLabel.text = time.isEmpty ? date : "\(date) · \(time)"
        let placeholder = UIImage(named: "football")
        team1Image.image = placeholder
        team2Image.image = placeholder
        if let homeUrl = match.homeTeamLogo { team1Image.loadImage(from: homeUrl, placeholder: placeholder) }
        if let awayUrl = match.awayTeamLogo { team2Image.loadImage(from: awayUrl, placeholder: placeholder) }
    }
}
