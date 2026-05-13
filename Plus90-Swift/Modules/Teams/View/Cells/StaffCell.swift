import UIKit

class StaffCell: UICollectionViewCell {

    @IBOutlet weak var staffImg: UIImageView!
    @IBOutlet weak var staffNameLbl: UILabel!

    private let cardBg          = UIView()
    private let topAccentBar    = UIView()
    private let roleTagView     = UIView()
    private let roleLabel       = UILabel()
    private let shimmerLayer    = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        shimmerLayer.frame = cardBg.bounds
        staffImg.layer.cornerRadius = staffImg.bounds.width / 2
    }

    private func setupUI() {
        clipsToBounds = false
        backgroundColor = .clear
        layer.shadowColor  = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.25

        cardBg.translatesAutoresizingMaskIntoConstraints = false
        cardBg.backgroundColor = UIColor(red: 0.10, green: 0.13, blue: 0.11, alpha: 1)
        cardBg.layer.cornerRadius = 16
        cardBg.clipsToBounds = true
        insertSubview(cardBg, at: 0)

        shimmerLayer.colors = [
            UIColor.white.withAlphaComponent(0.05).cgColor,
            UIColor.clear.cgColor
        ]
        shimmerLayer.startPoint = CGPoint(x: 0, y: 0)
        shimmerLayer.endPoint   = CGPoint(x: 0, y: 0.5)
        cardBg.layer.addSublayer(shimmerLayer)

        topAccentBar.translatesAutoresizingMaskIntoConstraints = false
        topAccentBar.backgroundColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1)
        topAccentBar.layer.cornerRadius = 2
        cardBg.addSubview(topAccentBar)

        staffImg.translatesAutoresizingMaskIntoConstraints = false
        staffImg.clipsToBounds = true
        staffImg.contentMode = .scaleAspectFit
        staffImg.layer.borderWidth = 2.5
        staffImg.layer.borderColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 0.6).cgColor
        staffImg.backgroundColor = UIColor(white: 1, alpha: 0.06)
        cardBg.addSubview(staffImg)

        roleTagView.translatesAutoresizingMaskIntoConstraints = false
        roleTagView.backgroundColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 0.18)
        roleTagView.layer.cornerRadius = 8
        roleTagView.layer.borderWidth = 0.5
        roleTagView.layer.borderColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 0.4).cgColor
        cardBg.addSubview(roleTagView)

        roleLabel.translatesAutoresizingMaskIntoConstraints = false
        roleLabel.text = "STAFF"
        roleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 9) ??
                         .systemFont(ofSize: 9, weight: .semibold)
        roleLabel.textColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1)
        roleLabel.textAlignment = .center
        roleTagView.addSubview(roleLabel)

        staffNameLbl.translatesAutoresizingMaskIntoConstraints = false
        staffNameLbl.font = UIFont(name: "AvenirNext-DemiBold", size: 12) ??
                            .systemFont(ofSize: 12, weight: .semibold)
        staffNameLbl.textColor = .white
        staffNameLbl.textAlignment = .center
        staffNameLbl.numberOfLines = 2
        cardBg.addSubview(staffNameLbl)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardBg.topAnchor.constraint(equalTo: topAnchor),
            cardBg.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardBg.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardBg.bottomAnchor.constraint(equalTo: bottomAnchor),

            topAccentBar.topAnchor.constraint(equalTo: cardBg.topAnchor),
            topAccentBar.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor),
            topAccentBar.trailingAnchor.constraint(equalTo: cardBg.trailingAnchor),
            topAccentBar.heightAnchor.constraint(equalToConstant: 3),

            staffImg.topAnchor.constraint(equalTo: topAccentBar.bottomAnchor, constant: 16),
            staffImg.centerXAnchor.constraint(equalTo: cardBg.centerXAnchor),
            staffImg.widthAnchor.constraint(equalToConstant: 64),
            staffImg.heightAnchor.constraint(equalToConstant: 64),

            roleTagView.topAnchor.constraint(equalTo: staffImg.bottomAnchor, constant: 8),
            roleTagView.centerXAnchor.constraint(equalTo: cardBg.centerXAnchor),
            roleTagView.heightAnchor.constraint(equalToConstant: 18),
            roleTagView.widthAnchor.constraint(greaterThanOrEqualToConstant: 44),

            roleLabel.topAnchor.constraint(equalTo: roleTagView.topAnchor, constant: 3),
            roleLabel.bottomAnchor.constraint(equalTo: roleTagView.bottomAnchor, constant: -3),
            roleLabel.leadingAnchor.constraint(equalTo: roleTagView.leadingAnchor, constant: 6),
            roleLabel.trailingAnchor.constraint(equalTo: roleTagView.trailingAnchor, constant: -6),

            staffNameLbl.topAnchor.constraint(equalTo: roleTagView.bottomAnchor, constant: 6),
            staffNameLbl.leadingAnchor.constraint(equalTo: cardBg.leadingAnchor, constant: 8),
            staffNameLbl.trailingAnchor.constraint(equalTo: cardBg.trailingAnchor, constant: -8),
            staffNameLbl.bottomAnchor.constraint(lessThanOrEqualTo: cardBg.bottomAnchor, constant: -10)
        ])
    }

    func configure(with coach: Coach) {
        staffNameLbl.text = coach.coachName ?? "Head Coach"

        
            roleLabel.text = "COACH"
       

        if let urlString = coach.coachImage, !urlString.isEmpty {
            staffImg.loadImage(from: urlString, placeholder: UIImage(named: "coach_placeholder"))
        } else {
            staffImg.image = UIImage(named: "coach_placeholder")
        }
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.transform = self.isHighlighted
                    ? CGAffineTransform(scaleX: 0.96, y: 0.96)
                    : .identity
            }
        }
    }
}
