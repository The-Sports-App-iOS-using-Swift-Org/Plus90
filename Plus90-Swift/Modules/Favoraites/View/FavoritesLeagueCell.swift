//
//  FavoriteLeagueCell.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 06/05/2026.
//

import UIKit

class FavoriteLeagueCell: UITableViewCell {
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemGray6
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let regionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = .systemGray3
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupHierarchy()
            self.layoutIfNeeded()
        }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
    }
    
    private func setupHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(textStackView)
        contentView.addSubview(chevronImageView)
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(regionLabel)
    }
    

    
    func configure(with league: FavoriteLeague) {
        titleLabel.text = league.name
        regionLabel.text = league.region
        iconImageView.image = UIImage(named: league.imageName)
    }
}
