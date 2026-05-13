//
//  LatestEventCollectionViewCell.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 08/05/2026.
//

import UIKit

class LatestEventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var homTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var scoreViewContainer: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateIcon: UIImageView!
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
        homeTeamImage.layer.cornerRadius = homeTeamImage.frame.width / 2
        awayTeamImage.layer.cornerRadius = awayTeamImage.frame.width / 2
    }
    private func setupUI() {
        cardContainer.layer.cornerRadius = 16
        cardContainer.layer.shadowColor = UIColor.black.cgColor
        cardContainer.layer.shadowOpacity = 0.08
        cardContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardContainer.layer.shadowRadius = 8
        cardContainer.layer.masksToBounds = false
        scoreViewContainer.layer.cornerRadius = 8
        scoreLabel.font = .systemFont(ofSize: 16, weight: .bold)
        homeTeamImage.clipsToBounds = true
        awayTeamImage.clipsToBounds = true
        leagueLabel.font = .systemFont(ofSize: 12, weight: .medium)
        statusLabel.font = .systemFont(ofSize: 14, weight: .medium)
        homTeamNameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        awayTeamNameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        applyTheme()
    }
    private func applyTheme() {
        cardContainer.backgroundColor = AppColors.cardBackground
        scoreViewContainer.backgroundColor = AppColors.secondaryBackground
        scoreLabel.textColor = AppColors.accent
        leagueLabel.textColor = AppColors.secondaryText
        statusLabel.textColor = AppColors.accent
        homTeamNameLabel.textColor = AppColors.primaryText
        awayTeamNameLabel.textColor = AppColors.primaryText
        dateLabel.textColor = AppColors.secondaryText
    }
    func configure(with match: MatchEvent) {
        leagueLabel.text = match.leagueName?.uppercased()
        statusLabel.text = match.eventStatus
        homTeamNameLabel.text = match.eventHomeTeam
        awayTeamNameLabel.text = match.eventAwayTeam
        scoreLabel.text = match.eventFinalResult
        dateLabel.text = "\(match.eventDate ?? ""), \(match.eventTime ?? "")"
        homeTeamImage.loadImage(from: match.homeTeamLogo ?? "", placeholder: UIImage(named: "placeholder"))
        awayTeamImage.loadImage(from: match.awayTeamLogo ?? "", placeholder: UIImage(named: "placeholder"))
    }
}
