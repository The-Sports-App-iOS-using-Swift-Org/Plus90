//
//  PlayerCell.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 7/05/2026.
//

import UIKit

class PlayerCell: UICollectionViewCell {

    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var numberBg: UIView!
    @IBOutlet weak var playerNumberLbl: UILabel!
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerPositionLbl: UILabel!

    private let cardBg        = UIView()
    private let leftAccent    = UIView()
    private let positionBadge = UIView()
    private let divider       = UIView()
    private let chevronIcon   = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 14).cgPath
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyThemeColors()
        if let position = playerPositionLbl.text {
            stylePositionBadge(for: position)
        }
    }

    private func setupUI() {
        clipsToBounds = false
        backgroundColor = .clear
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0, height: 3)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.15

        cardBg.translatesAutoresizingMaskIntoConstraints = false
        cardBg.layer.cornerRadius = 14
        cardBg.clipsToBounds = true
        insertSubview(cardBg, at: 0)

        leftAccent.translatesAutoresizingMaskIntoConstraints = false
        leftAccent.layer.cornerRadius = 2
        cardBg.addSubview(leftAccent)

        numberBg.translatesAutoresizingMaskIntoConstraints = false
        numberBg.layer.cornerRadius = 10
        numberBg.layer.borderWidth  = 1
        cardBg.addSubview(numberBg)

        playerNumberLbl.translatesAutoresizingMaskIntoConstraints = false
        playerNumberLbl.font = UIFont(name: "AvenirNext-Heavy", size: 16) ??
                               .systemFont(ofSize: 16, weight: .heavy)
        playerNumberLbl.textAlignment = .center
        numberBg.addSubview(playerNumberLbl)

        playerImg.translatesAutoresizingMaskIntoConstraints = false
        playerImg.layer.cornerRadius = 24
        playerImg.clipsToBounds = true
        playerImg.contentMode = .scaleAspectFit
        playerImg.layer.borderWidth = 1.5
        cardBg.addSubview(playerImg)

        divider.translatesAutoresizingMaskIntoConstraints = false
        cardBg.addSubview(divider)

        playerNameLbl.translatesAutoresizingMaskIntoConstraints = false
        playerNameLbl.font = UIFont(name: "AvenirNext-DemiBold", size: 14) ??
                             .systemFont(ofSize: 14, weight: .semibold)
        cardBg.addSubview(playerNameLbl)

        positionBadge.translatesAutoresizingMaskIntoConstraints = false
        positionBadge.layer.cornerRadius = 9
        positionBadge.clipsToBounds = true
        positionBadge.layer.borderWidth = 0.5
        cardBg.addSubview(positionBadge)

        playerPositionLbl.translatesAutoresizingMaskIntoConstraints = false
        playerPositionLbl.font = UIFont(name: "AvenirNext-DemiBold", size: 10) ??
                                 .systemFont(ofSize: 10, weight: .semibold)
        playerPositionLbl.textAlignment = .center
        positionBadge.addSubview(playerPositionLbl)

        chevronIcon.translatesAutoresizingMaskIntoConstraints = false
        chevronIcon.image = UIImage(systemName: "chevron.right")
        chevronIcon.contentMode = .scaleAspectFit
        cardBg.addSubview(chevronIcon)

        applyThemeColors()
        setupConstraints()
    }

    private func applyThemeColors() {
        let accent = AppColors.accent

        cardBg.backgroundColor = AppColors.cardBackground

        leftAccent.backgroundColor = accent

        numberBg.backgroundColor   = accent.withAlphaComponent(0.15)
        numberBg.layer.borderColor = accent.withAlphaComponent(0.35).cgColor
        playerNumberLbl.textColor  = accent

        playerImg.layer.borderColor  = AppColors.separator.cgColor
        playerImg.backgroundColor    = AppColors.secondaryBackground

        divider.backgroundColor = AppColors.separator

        playerNameLbl.textColor = AppColors.primaryText

        chevronIcon.tintColor = AppColors.secondaryText
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardBg.topAnchor.constraint(equalTo: topAnchor),
            cardBg.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardBg.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardBg.bottomAnchor.constraint(equalTo: bottomAnchor),

            leftAccent.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor),
            leftAccent.topAnchor.constraint(equalTo: cardBg.topAnchor),
            leftAccent.bottomAnchor.constraint(equalTo: cardBg.bottomAnchor),
            leftAccent.widthAnchor.constraint(equalToConstant: 4),

            numberBg.leadingAnchor.constraint(equalTo: leftAccent.trailingAnchor, constant: 12),
            numberBg.centerYAnchor.constraint(equalTo: cardBg.centerYAnchor),
            numberBg.widthAnchor.constraint(equalToConstant: 38),
            numberBg.heightAnchor.constraint(equalToConstant: 38),

            playerNumberLbl.centerXAnchor.constraint(equalTo: numberBg.centerXAnchor),
            playerNumberLbl.centerYAnchor.constraint(equalTo: numberBg.centerYAnchor),

            playerImg.leadingAnchor.constraint(equalTo: numberBg.trailingAnchor, constant: 10),
            playerImg.centerYAnchor.constraint(equalTo: cardBg.centerYAnchor),
            playerImg.widthAnchor.constraint(equalToConstant: 48),
            playerImg.heightAnchor.constraint(equalToConstant: 48),

            divider.leadingAnchor.constraint(equalTo: playerImg.trailingAnchor, constant: 10),
            divider.centerYAnchor.constraint(equalTo: cardBg.centerYAnchor),
            divider.widthAnchor.constraint(equalToConstant: 1),
            divider.heightAnchor.constraint(equalToConstant: 30),

            chevronIcon.trailingAnchor.constraint(equalTo: cardBg.trailingAnchor, constant: -14),
            chevronIcon.centerYAnchor.constraint(equalTo: cardBg.centerYAnchor),
            chevronIcon.widthAnchor.constraint(equalToConstant: 10),
            chevronIcon.heightAnchor.constraint(equalToConstant: 14),

            playerNameLbl.leadingAnchor.constraint(equalTo: divider.trailingAnchor, constant: 12),
            playerNameLbl.trailingAnchor.constraint(equalTo: chevronIcon.leadingAnchor, constant: -8),
            playerNameLbl.topAnchor.constraint(equalTo: cardBg.topAnchor, constant: 16),

            positionBadge.leadingAnchor.constraint(equalTo: divider.trailingAnchor, constant: 12),
            positionBadge.topAnchor.constraint(equalTo: playerNameLbl.bottomAnchor, constant: 5),
            positionBadge.heightAnchor.constraint(equalToConstant: 20),

            playerPositionLbl.topAnchor.constraint(equalTo: positionBadge.topAnchor, constant: 3),
            playerPositionLbl.bottomAnchor.constraint(equalTo: positionBadge.bottomAnchor, constant: -3),
            playerPositionLbl.leadingAnchor.constraint(equalTo: positionBadge.leadingAnchor, constant: 8),
            playerPositionLbl.trailingAnchor.constraint(equalTo: positionBadge.trailingAnchor, constant: -8)
        ])
    }

    func configure(with player: Player) {
        playerNameLbl.text   = player.playerName   ?? "Unknown Player"
        playerNumberLbl.text = player.playerNumber ?? "--"

        let position = player.playerType ?? "N/A"
        playerPositionLbl.text = position.uppercased()
        stylePositionBadge(for: position)

        if let urlString = player.playerImage, !urlString.isEmpty {
            playerImg.loadImage(from: urlString, placeholder: UIImage(named: "player_placeholder"))
        } else {
            playerImg.image = UIImage(named: "player_placeholder")
            playerImg.backgroundColor = AppColors.secondaryBackground
        }
    }

    private func stylePositionBadge(for position: String) {
        let pos = position.uppercased()
        let (bg, text): (UIColor, UIColor)

        switch true {
        case pos.contains("GK") || pos.contains("GOAL"):
            bg   = UIColor(red: 0.98, green: 0.75, blue: 0.18, alpha: 0.20)
            text = UIColor(red: 0.98, green: 0.75, blue: 0.18, alpha: 1)
        case pos.contains("DEF") || pos.contains("CB") || pos.contains("LB") || pos.contains("RB"):
            bg   = UIColor(red: 0.25, green: 0.55, blue: 1.0, alpha: 0.20)
            text = UIColor(red: 0.45, green: 0.70, blue: 1.0, alpha: 1)
        case pos.contains("MID") || pos.contains("CM") || pos.contains("DM") || pos.contains("AM"):
            // Use AppColors.accent so it adapts between dark (#01632A) and light (#008337)
            bg   = AppColors.accent.withAlphaComponent(0.20)
            text = AppColors.accent
        case pos.contains("FWD") || pos.contains("ST") || pos.contains("LW") ||
             pos.contains("RW") || pos.contains("ATT"):
            bg   = UIColor(red: 1.0, green: 0.38, blue: 0.28, alpha: 0.20)
            text = UIColor(red: 1.0, green: 0.50, blue: 0.40, alpha: 1)
        default:
            bg   = AppColors.secondaryBackground.withAlphaComponent(0.5)
            text = AppColors.secondaryText
        }

        positionBadge.backgroundColor    = bg
        positionBadge.layer.borderColor  = text.withAlphaComponent(0.30).cgColor
        playerPositionLbl.textColor      = text
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.12) {
                self.transform = self.isHighlighted
                    ? CGAffineTransform(scaleX: 0.97, y: 0.97)
                    : .identity
                self.cardBg.backgroundColor = self.isHighlighted
                    ? AppColors.secondaryBackground
                    : AppColors.cardBackground
            }
        }
    }
}
