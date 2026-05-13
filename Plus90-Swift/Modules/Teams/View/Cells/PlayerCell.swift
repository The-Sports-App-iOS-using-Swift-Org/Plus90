import UIKit

class PlayerCell: UICollectionViewCell {

    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var numberBg: UIView!
    @IBOutlet weak var playerNumberLbl: UILabel!
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerPositionLbl: UILabel!

    private let cardBg         = UIView()
    private let leftAccent     = UIView()
    private let positionBadge  = UIView()
    private let divider        = UIView()
    private let chevronIcon    = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
    }

    private func setupUI() {
        clipsToBounds = false
        backgroundColor = .clear

        cardBg.translatesAutoresizingMaskIntoConstraints = false
        cardBg.backgroundColor = UIColor(red: 0.10, green: 0.13, blue: 0.11, alpha: 1)
        cardBg.layer.cornerRadius = 14
        cardBg.clipsToBounds = true
        insertSubview(cardBg, at: 0)

        leftAccent.translatesAutoresizingMaskIntoConstraints = false
        leftAccent.backgroundColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1)
        leftAccent.layer.cornerRadius = 2
        cardBg.addSubview(leftAccent)

        numberBg.translatesAutoresizingMaskIntoConstraints = false
        numberBg.backgroundColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 0.15)
        numberBg.layer.cornerRadius = 10
        numberBg.layer.borderWidth = 1
        numberBg.layer.borderColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 0.35).cgColor
        cardBg.addSubview(numberBg)

        playerNumberLbl.translatesAutoresizingMaskIntoConstraints = false
        playerNumberLbl.font = UIFont(name: "AvenirNext-Heavy", size: 16) ??
                               .systemFont(ofSize: 16, weight: .heavy)
        playerNumberLbl.textColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1)
        playerNumberLbl.textAlignment = .center
        numberBg.addSubview(playerNumberLbl)

        playerImg.translatesAutoresizingMaskIntoConstraints = false
        playerImg.layer.cornerRadius = 24
        playerImg.clipsToBounds = true
        playerImg.contentMode = .scaleAspectFit
        playerImg.layer.borderWidth = 1.5
        playerImg.layer.borderColor = UIColor(white: 1, alpha: 0.12).cgColor
        playerImg.backgroundColor = UIColor(white: 1, alpha: 0.06)
        cardBg.addSubview(playerImg)

        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = UIColor(white: 1, alpha: 0.07)
        cardBg.addSubview(divider)

        playerNameLbl.translatesAutoresizingMaskIntoConstraints = false
        playerNameLbl.font = UIFont(name: "AvenirNext-DemiBold", size: 14) ??
                             .systemFont(ofSize: 14, weight: .semibold)
        playerNameLbl.textColor = .white
        cardBg.addSubview(playerNameLbl)

        positionBadge.translatesAutoresizingMaskIntoConstraints = false
        positionBadge.layer.cornerRadius = 9
        positionBadge.clipsToBounds = true
        cardBg.addSubview(positionBadge)

        playerPositionLbl.translatesAutoresizingMaskIntoConstraints = false
        playerPositionLbl.font = UIFont(name: "AvenirNext-DemiBold", size: 10) ??
                                 .systemFont(ofSize: 10, weight: .semibold)
        playerPositionLbl.textAlignment = .center
        positionBadge.addSubview(playerPositionLbl)

        chevronIcon.translatesAutoresizingMaskIntoConstraints = false
        chevronIcon.image = UIImage(systemName: "chevron.right")
        chevronIcon.tintColor = UIColor(white: 1, alpha: 0.25)
        chevronIcon.contentMode = .scaleAspectFit
        cardBg.addSubview(chevronIcon)

        setupConstraints()
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

    private func updateShadow() {
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0, height: 3)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.2
        layer.shadowPath    = UIBezierPath(roundedRect: bounds, cornerRadius: 14).cgPath
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
            playerImg.backgroundColor = UIColor(white: 1, alpha: 0.06)
        }
    }

    private func stylePositionBadge(for position: String) {
        let pos = position.uppercased()
        let (bg, text): (UIColor, UIColor)
        switch true {
        case pos.contains("GK") || pos.contains("GOAL"):
            bg = UIColor(red: 0.98, green: 0.75, blue: 0.18, alpha: 0.20)
            text = UIColor(red: 0.98, green: 0.75, blue: 0.18, alpha: 1)
        case pos.contains("DEF") || pos.contains("CB") || pos.contains("LB") || pos.contains("RB"):
            bg = UIColor(red: 0.25, green: 0.55, blue: 1.0, alpha: 0.20)
            text = UIColor(red: 0.45, green: 0.70, blue: 1.0, alpha: 1)
        case pos.contains("MID") || pos.contains("CM") || pos.contains("DM") || pos.contains("AM"):
            bg = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 0.20)
            text = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1)
        case pos.contains("FWD") || pos.contains("ST") || pos.contains("LW") || pos.contains("RW") || pos.contains("ATT"):
            bg = UIColor(red: 1.0, green: 0.38, blue: 0.28, alpha: 0.20)
            text = UIColor(red: 1.0, green: 0.50, blue: 0.40, alpha: 1)
        default:
            bg = UIColor(white: 1, alpha: 0.10)
            text = UIColor(white: 1, alpha: 0.6)
        }
        positionBadge.backgroundColor = bg
        positionBadge.layer.borderColor = text.withAlphaComponent(0.3).cgColor
        positionBadge.layer.borderWidth = 0.5
        playerPositionLbl.textColor = text
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.12) {
                self.transform = self.isHighlighted
                    ? CGAffineTransform(scaleX: 0.97, y: 0.97)
                    : .identity
                self.cardBg.backgroundColor = self.isHighlighted
                    ? UIColor(red: 0.14, green: 0.18, blue: 0.15, alpha: 1)
                    : UIColor(red: 0.10, green: 0.13, blue: 0.11, alpha: 1)
            }
        }
    }
}
