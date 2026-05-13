import UIKit

class TeamSectionHeaderView: UICollectionReusableView {

    private let titleLabel = UILabel()
    private let accentBar = UIView()
    private let subtitleDot = UIView()
    private let containerStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear

        accentBar.backgroundColor = UIColor(named: "PitchGreen") ?? UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1.0)
        accentBar.layer.cornerRadius = 2
        accentBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(accentBar)

        titleLabel.font = UIFont(name: "AvenirNext-Heavy", size: 15) ??
                          .systemFont(ofSize: 15, weight: .heavy)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.letterSpacing(1.5)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        let separatorView = GradientLineView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorView)

        NSLayoutConstraint.activate([
            accentBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            accentBar.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -4),
            accentBar.widthAnchor.constraint(equalToConstant: 4),
            accentBar.heightAnchor.constraint(equalToConstant: 18),

            titleLabel.leadingAnchor.constraint(equalTo: accentBar.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: accentBar.centerYAnchor),

            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func configure(title: String) {
        titleLabel.text = title.uppercased()
        accentBar.isHidden = title.isEmpty
    }
}

private class GradientLineView: UIView {
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        let green = UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1.0)
        gradientLayer.colors = [green.cgColor, green.withAlphaComponent(0.3).cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(gradientLayer)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

private extension UILabel {
    func letterSpacing(_ spacing: CGFloat) {
        guard let text = self.text else { return }
        let attributed = NSAttributedString(string: text, attributes: [.kern: spacing])
        self.attributedText = attributed
    }
}
