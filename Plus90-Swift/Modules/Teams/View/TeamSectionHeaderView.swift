//
//  TeamSectionHeaderView.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 09/05/2026.
//

import UIKit

class TeamSectionHeaderView: UICollectionReusableView {
    
    let titleLabel = UILabel()
    private let bottomLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = .label
        addSubview(titleLabel)
        
        bottomLine.backgroundColor = .systemGray5
        addSubview(bottomLine)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configure(title: String) {
        titleLabel.text = title
        bottomLine.isHidden = title.isEmpty
    }
}
