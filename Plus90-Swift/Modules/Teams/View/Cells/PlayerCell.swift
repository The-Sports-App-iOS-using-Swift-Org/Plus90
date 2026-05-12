//
//  PlayerCell.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 09/05/2026.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    
    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var numberBg: UIView!
    @IBOutlet weak var playerNumberLbl: UILabel!
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerPositionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.backgroundColor = .systemBackground
        
        playerImg.layer.cornerRadius = 25
        playerImg.clipsToBounds = true
        playerImg.layer.borderWidth = 1
        playerImg.layer.borderColor = UIColor.systemGray4.cgColor
        
        numberBg.layer.cornerRadius = 11
        numberBg.clipsToBounds = true
    }
    
    func configure(with player: Player) {
        playerNameLbl.text = player.playerName ?? "Unknown Player"
        playerNumberLbl.text = player.playerNumber ?? "--"
        playerPositionLbl.text = player.playerType ?? "N/A"
        
        if let urlString = player.playerImage, !urlString.isEmpty {
            playerImg.contentMode = .scaleAspectFit
            playerImg.backgroundColor = .clear
            playerImg.loadImage(from: urlString, placeholder: UIImage(named: "player_placeholder"))
        } else {
            playerImg.contentMode = .scaleAspectFit
            playerImg.image = UIImage(named: "player_placeholder")
            playerImg.backgroundColor = .systemGray6
        }
    }
}
