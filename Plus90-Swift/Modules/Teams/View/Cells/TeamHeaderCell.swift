import UIKit

class TeamHeaderCell: UICollectionViewCell {

    @IBOutlet weak var teamLogoImg: UIImageView!
    @IBOutlet weak var teamNameLbl: UILabel!

    // MARK: - Extra UI (programmatic overlays)
    private let stadiumBgView     = UIView()
    private let patternOverlay    = FootballPatternView()
    private let glowRing          = UIView()
    private let logoContainer     = UIView()
    private let nameTagView       = UIView()
    private let badgeIcon         = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrames()
        glowRing.layer.cornerRadius = glowRing.bounds.width / 2
        logoContainer.layer.cornerRadius = logoContainer.bounds.width / 2
    }

    private func setupUI() {
        clipsToBounds = false
        backgroundColor = .clear

        stadiumBgView.translatesAutoresizingMaskIntoConstraints = false
        stadiumBgView.clipsToBounds = true
        insertSubview(stadiumBgView, at: 0)

        let bgGradient = CAGradientLayer()
        bgGradient.colors = [
            UIColor(red: 0.05, green: 0.12, blue: 0.08, alpha: 1).cgColor,
            UIColor(red: 0.02, green: 0.06, blue: 0.04, alpha: 1).cgColor
        ]
        bgGradient.startPoint = CGPoint(x: 0, y: 0)
        bgGradient.endPoint   = CGPoint(x: 1, y: 1)
        bgGradient.name = "bgGradient"
        stadiumBgView.layer.insertSublayer(bgGradient, at: 0)

        patternOverlay.translatesAutoresizingMaskIntoConstraints = false
        patternOverlay.alpha = 0.06
        stadiumBgView.addSubview(patternOverlay)

        glowRing.translatesAutoresizingMaskIntoConstraints = false
        glowRing.backgroundColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 0.15)
        glowRing.layer.shadowColor  = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1).cgColor
        glowRing.layer.shadowRadius = 24
        glowRing.layer.shadowOpacity = 0.5
        glowRing.layer.shadowOffset = .zero
        stadiumBgView.addSubview(glowRing)

        logoContainer.translatesAutoresizingMaskIntoConstraints = false
        logoContainer.backgroundColor = UIColor(white: 1, alpha: 0.08)
        logoContainer.layer.borderWidth = 1.5
        logoContainer.layer.borderColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 0.4).cgColor
        stadiumBgView.addSubview(logoContainer)

        teamLogoImg.translatesAutoresizingMaskIntoConstraints = false
        teamLogoImg.contentMode = .scaleAspectFit
        teamLogoImg.layer.cornerRadius = 0
        logoContainer.addSubview(teamLogoImg)

        nameTagView.translatesAutoresizingMaskIntoConstraints = false
        nameTagView.backgroundColor = UIColor(white: 1, alpha: 0.08)
        nameTagView.layer.cornerRadius = 14
        nameTagView.layer.borderWidth = 1
        nameTagView.layer.borderColor = UIColor(white: 1, alpha: 0.12).cgColor
        stadiumBgView.addSubview(nameTagView)

        badgeIcon.image = UIImage(systemName: "soccerball")
        badgeIcon.tintColor = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1)
        badgeIcon.translatesAutoresizingMaskIntoConstraints = false
        nameTagView.addSubview(badgeIcon)

        teamNameLbl.translatesAutoresizingMaskIntoConstraints = false
        teamNameLbl.font = UIFont(name: "AvenirNext-Heavy", size: 20) ??
                           .systemFont(ofSize: 20, weight: .heavy)
        teamNameLbl.textColor = .white
        teamNameLbl.textAlignment = .left
        nameTagView.addSubview(teamNameLbl)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stadiumBgView.topAnchor.constraint(equalTo: topAnchor),
            stadiumBgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stadiumBgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stadiumBgView.bottomAnchor.constraint(equalTo: bottomAnchor),

            patternOverlay.topAnchor.constraint(equalTo: stadiumBgView.topAnchor),
            patternOverlay.leadingAnchor.constraint(equalTo: stadiumBgView.leadingAnchor),
            patternOverlay.trailingAnchor.constraint(equalTo: stadiumBgView.trailingAnchor),
            patternOverlay.bottomAnchor.constraint(equalTo: stadiumBgView.bottomAnchor),

            glowRing.centerXAnchor.constraint(equalTo: stadiumBgView.centerXAnchor),
            glowRing.centerYAnchor.constraint(equalTo: stadiumBgView.centerYAnchor, constant: -20),
            glowRing.widthAnchor.constraint(equalToConstant: 110),
            glowRing.heightAnchor.constraint(equalToConstant: 110),

            logoContainer.centerXAnchor.constraint(equalTo: stadiumBgView.centerXAnchor),
            logoContainer.centerYAnchor.constraint(equalTo: stadiumBgView.centerYAnchor, constant: -20),
            logoContainer.widthAnchor.constraint(equalToConstant: 90),
            logoContainer.heightAnchor.constraint(equalToConstant: 90),

            teamLogoImg.topAnchor.constraint(equalTo: logoContainer.topAnchor, constant: 8),
            teamLogoImg.leadingAnchor.constraint(equalTo: logoContainer.leadingAnchor, constant: 8),
            teamLogoImg.trailingAnchor.constraint(equalTo: logoContainer.trailingAnchor, constant: -8),
            teamLogoImg.bottomAnchor.constraint(equalTo: logoContainer.bottomAnchor, constant: -8),

            nameTagView.centerXAnchor.constraint(equalTo: stadiumBgView.centerXAnchor),
            nameTagView.topAnchor.constraint(equalTo: logoContainer.bottomAnchor, constant: 16),
            nameTagView.heightAnchor.constraint(equalToConstant: 36),

            badgeIcon.leadingAnchor.constraint(equalTo: nameTagView.leadingAnchor, constant: 12),
            badgeIcon.centerYAnchor.constraint(equalTo: nameTagView.centerYAnchor),
            badgeIcon.widthAnchor.constraint(equalToConstant: 16),
            badgeIcon.heightAnchor.constraint(equalToConstant: 16),

            teamNameLbl.leadingAnchor.constraint(equalTo: badgeIcon.trailingAnchor, constant: 8),
            teamNameLbl.trailingAnchor.constraint(equalTo: nameTagView.trailingAnchor, constant: -14),
            teamNameLbl.centerYAnchor.constraint(equalTo: nameTagView.centerYAnchor)
        ])
    }

    private func updateGradientFrames() {
        if let bgGradient = stadiumBgView.layer.sublayers?.first(where: { $0.name == "bgGradient" }) {
            bgGradient.frame = stadiumBgView.bounds
        }
    }

    func configure(name: String?, logoUrl: String?) {
        teamNameLbl.text = name ?? "Unknown Team"
        if let url = logoUrl {
            teamLogoImg.loadImage(from: url, placeholder: UIImage(named: "team_placeholder"))
        }
        logoContainer.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        logoContainer.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.5) {
            self.logoContainer.transform = .identity
            self.logoContainer.alpha = 1
        }
        nameTagView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.35) {
            self.nameTagView.alpha = 1
        }
    }
}

private class FootballPatternView: UIView {
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setLineWidth(18)
        let stripeWidth: CGFloat = 40
        var x: CGFloat = -stripeWidth
        while x < rect.width + stripeWidth {
            ctx.move(to: CGPoint(x: x, y: 0))
            ctx.addLine(to: CGPoint(x: x, y: rect.height))
            x += stripeWidth
        }
        ctx.strokePath()
    }
}
