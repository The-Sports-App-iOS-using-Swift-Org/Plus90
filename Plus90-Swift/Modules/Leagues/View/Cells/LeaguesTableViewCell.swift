//
//  LeaguesTableViewCell.swift
//  Plus90-Swift
//
//  Created by Nemo on 07/05/2026.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {
    @IBOutlet private weak var leagueImage: UIImageView!
    @IBOutlet private weak var leagueCountryTitle: UILabel!
    @IBOutlet private weak var leagueTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
        contentView.layer.cornerRadius = 12
        let size = min(leagueImage.frame.size.width, leagueImage.frame.size.height)
        leagueImage.layer.cornerRadius = size / 2
    }
    
    private func setupCellUI() {
        self.backgroundColor = .clear
        
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        
        // Shadow على الـ cell نفسها مش الـ contentView
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.08
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 6
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 12
        
        // Image
        leagueImage.contentMode = .scaleAspectFill
        leagueImage.clipsToBounds = true
        leagueImage.layer.cornerRadius = 35
        leagueImage.layer.borderWidth = 1.0
        leagueImage.layer.borderColor = UIColor.systemGray5.cgColor
        
        // Labels
        leagueTitle.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        leagueTitle.textColor = .label
        leagueCountryTitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        leagueCountryTitle.textColor = .secondaryLabel
        
        self.contentView.preservesSuperviewLayoutMargins = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with league: League, placeholderName: String) {
        leagueTitle.text = league.leagueName
        leagueCountryTitle.text = league.countryName ?? "International"
        let imageUrl = league.leagueLogo ?? ""
        leagueImage.loadImage(from: imageUrl, placeholder: UIImage(named: placeholderName))
    }
}
