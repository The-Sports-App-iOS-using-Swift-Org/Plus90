//
//  StaffCell.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 09/05/2026.
//

import UIKit

class StaffCell: UICollectionViewCell {
    
    @IBOutlet weak var staffImg: UIImageView!
    @IBOutlet weak var staffNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        staffImg.layer.cornerRadius = staffImg.frame.size.width / 2
    }
    
    private func setupUI() {
        staffImg.clipsToBounds = true
        staffImg.contentMode = .scaleAspectFill
        staffImg.layer.borderWidth = 1.5
        staffImg.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    func configure(with coach: Coach) {
        staffNameLbl.text = coach.coachName ?? "Head Coach"
        
        if let urlString = coach.coachImage, !urlString.isEmpty {
            staffImg.contentMode = .scaleAspectFit
            staffImg.loadImage(from: urlString, placeholder: UIImage(named: "coach_placeholder"))
        } else {
            staffImg.contentMode = .scaleAspectFit
            staffImg.image = UIImage(named: "coach_placeholder")
        }
    }
}
