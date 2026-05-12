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
    @IBOutlet weak var dateAndTime: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.08
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 6
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 12

        team1Image.contentMode = .scaleAspectFit
        team1Image.clipsToBounds = true
        team1Image.layer.cornerRadius = 8
        
        team2Image.contentMode = .scaleAspectFit
        team2Image.clipsToBounds = true
        team2Image.layer.cornerRadius = 8
        
        team1Name.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        team1Name.textAlignment = .center
        team1Name.numberOfLines = 2
        
        team2Name.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        team2Name.textAlignment = .center
        team2Name.numberOfLines = 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 12
        ).cgPath
    }
    
    func configure(with match: MatchEvent) {
        team1Name.text = match.eventHomeTeam
        team2Name.text = match.eventAwayTeam
        dateLabel.text = "\(match.eventDate ?? "") \(match.eventTime ?? "")"
        
        let placeholder = UIImage(named: "football")
        team1Image.image = placeholder
        team2Image.image = placeholder
        
        if let homeUrl = match.homeTeamLogo {
            team1Image.loadImage(from: homeUrl, placeholder: placeholder)
        }
        if let awayUrl = match.awayTeamLogo {
            team2Image.loadImage(from: awayUrl, placeholder: placeholder)
        }
    }
}
