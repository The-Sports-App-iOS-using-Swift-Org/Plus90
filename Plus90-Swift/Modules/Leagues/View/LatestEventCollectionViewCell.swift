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

    private func setupUI() {
        cardContainer.layer.cornerRadius = 16
        cardContainer.backgroundColor = .white
        
        cardContainer.layer.shadowColor = UIColor.black.cgColor
        cardContainer.layer.shadowOpacity = 0.08
        cardContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardContainer.layer.shadowRadius = 8
        cardContainer.layer.masksToBounds = false
        
        scoreViewContainer.layer.cornerRadius = 8
        scoreViewContainer.backgroundColor = UIColor.systemGray6
        scoreLabel.textColor = UIColor(red: 21/255, green: 71/255, blue: 38/255, alpha: 1.0) // Dark Green
        scoreLabel.font = .systemFont(ofSize: 16, weight: .bold)

        homeTeamImage.layer.cornerRadius = homeTeamImage.frame.width / 2
        awayTeamImage.layer.cornerRadius = awayTeamImage.frame.width / 2
        homeTeamImage.clipsToBounds = true
        awayTeamImage.clipsToBounds = true
        
        leagueLabel.textColor = .secondaryLabel
        leagueLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        statusLabel.textColor = UIColor.systemGreen
        statusLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        homTeamNameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        awayTeamNameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
    }

    func configure(with match: MatchEvent) {
        leagueLabel.text = match.league_name.uppercased()
        statusLabel.text = match.event_status
        
        homTeamNameLabel.text = match.event_home_team
        awayTeamNameLabel.text = match.event_away_team
        
        scoreLabel.text = match.event_final_result
        
        dateLabel.text = "\(match.event_date), \(match.event_time)"
        
        homeTeamImage.loadImage(from: match.home_team_logo ?? "", placeholder: UIImage(named: "placeholder"))
        awayTeamImage.loadImage(from: match.away_team_logo ?? "", placeholder: UIImage(named: "placeholder"))
    }
}
