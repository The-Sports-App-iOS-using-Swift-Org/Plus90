//
//  TeamHeaderCell.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 09/05/2026.
//

import UIKit

class TeamHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var teamLogoImg: UIImageView!
    @IBOutlet weak var teamNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {

        teamLogoImg.contentMode = .scaleAspectFit
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            UIColor.systemGray6.cgColor,
            UIColor.systemBackground.cgColor
        ]
        self.backgroundView = UIView()
        self.backgroundView?.layer.insertSublayer(gradient, at: 0)
    }
    
    func configure(name: String?, logoUrl: String?) {
        teamNameLbl.text = name ?? "Unknown Team"
        
        if let url = logoUrl {
            teamLogoImg.loadImage(from: url, placeholder: UIImage(named: "team_placeholder"))
        }
    }
}
