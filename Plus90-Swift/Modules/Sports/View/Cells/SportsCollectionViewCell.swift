//
//  SportsCollectionViewCell.swift
//  Plus90-Swift
//
//  Created by Nemo on 06/05/2026.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportsTitle: UILabel!
    @IBOutlet weak var sportsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }
    private func setupCellUI() {
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
    }
    func configure(name: String, image: String) {
        sportsTitle.text = name
        sportsImage.image = UIImage(named: image)
    }
}
