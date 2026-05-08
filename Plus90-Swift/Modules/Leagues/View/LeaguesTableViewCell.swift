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
        leagueImage.layer.cornerRadius = leagueImage.frame.size.width / 2
        leagueImage.clipsToBounds = true
    }
    private func setupCellUI() {
        leagueImage.contentMode = .scaleAspectFill
        leagueImage.clipsToBounds = true
        leagueImage.layer.borderWidth = 1.0
        leagueImage.layer.borderColor = UIColor.systemGray5.cgColor
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
