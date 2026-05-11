//
//  UpcomingCollectionViewCell.swift
//  Plus90-Swift
//
//  Created by Nemo on 08/05/2026.
//

//
//  UpcomingCollectionViewCell.swift
//  Plus90-Swift
//
//  Created by Nemo on 08/05/2026.
//

import UIKit
import Alamofire

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
        clipsToBounds = false
        layer.masksToBounds = false
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.18
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        team1Image.layer.cornerRadius =
        team1Image.frame.height / 2
        team2Image.layer.cornerRadius =
        team2Image.frame.height / 2
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 16
        ).cgPath
    }
    
    func configure(with match: MatchEvent) {
            team1Name.text = match.eventHomeTeam
            team2Name.text = match.eventAwayTeam
            dateLabel.text = "\(match.eventDate ?? "")\n\(match.eventTime ?? "")"
            
            let placeholder = UIImage(named: "football")
            team1Image.image = placeholder
            team2Image.image = placeholder

            if let homeUrl = match.homeTeamLogo {
                AF.request(homeUrl).responseData { [weak self] response in
                    if let data = response.data, let image = UIImage(data: data) {
                        self?.team1Image.image = image
                    }
                }
            }
            
            if let awayUrl = match.awayTeamLogo {
                AF.request(awayUrl).responseData { [weak self] response in
                    if let data = response.data, let image = UIImage(data: data) {
                        self?.team2Image.image = image
                    }
                }
            }
        }
}
