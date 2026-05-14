import UIKit
import Network

class LeaguesDetailsViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var leagueTitleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var leaguesCompositionalLeaguesCollectionView: UICollectionView!

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemGreen
        indicator.hidesWhenStopped = true
        return indicator
    }()

    var leagueId: Int?
    var leagueName: String?
    var leagueRegion: String?
    var leagueImageUrl: String?

    private var presenter: LeaguesDetailsPresenterProtocol!
    private var upcomingEvents: [MatchEvent] = []
    private var latestEvents: [MatchEvent] = []
    private var teams: [Team] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        setupHeaderShape()
        setupUI()
        setupCollectionView()
        setupHeartImageGesture()
        setupBackButton()

        navigationController?.interactivePopGestureRecognizer?.delegate = self

        if let id = leagueId {
            presenter = LeaguesDetailsPresenter(view: self, leagueId: id)
            presenter.loadData()

            if let name = leagueName {
                presenter.checkFavoriteStatus(name: name)
            }
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        applyTheme()
    }

    private func applyTheme() {
        view.backgroundColor = AppColors.primaryBackground
        headerView.backgroundColor = AppColors.headerBackground
        leagueTitleLabel.textColor = .white
        activityIndicator.color = AppColors.accent
        leaguesCompositionalLeaguesCollectionView.backgroundColor = AppColors.primaryBackground
    }

    private func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        headerView.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            backButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupUI() {
        leagueTitleLabel.text = leagueName
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func setupHeaderShape() {
        headerView.layer.cornerRadius = 40
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner]
    }

    private func setupHeartImageGesture() {
        heartImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        heartImage.addGestureRecognizer(tapGesture)
    }

    private func setupCollectionView() {
        leaguesCompositionalLeaguesCollectionView.delegate = self
        leaguesCompositionalLeaguesCollectionView.dataSource = self
        leaguesCompositionalLeaguesCollectionView.register(UINib(nibName: "UpcomingCollectionViewCell", bundle: nil),    forCellWithReuseIdentifier: "UpcomingCollectionViewCell")
        leaguesCompositionalLeaguesCollectionView.register(UINib(nibName: "LatestEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LatestEventCell")
        leaguesCompositionalLeaguesCollectionView.register(UINib(nibName: "TeamsCollectionViewCell", bundle: nil),        forCellWithReuseIdentifier: "TeamsCell")
        leaguesCompositionalLeaguesCollectionView.register(EmptyStateCollectionViewCell.self,                             forCellWithReuseIdentifier: "EmptyStateCell")
        leaguesCompositionalLeaguesCollectionView.register(SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeaderView")

        leaguesCompositionalLeaguesCollectionView.setCollectionViewLayout(createCompositionalLayout(), animated: false)
    }

    @objc private func favoriteTapped() {
        guard let name = leagueName, let image = leagueImageUrl else { return }
        UIView.animate(withDuration: 0.1, animations: {
            self.heartImage.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { _ in
            UIView.animate(withDuration: 0.1) { self.heartImage.transform = .identity }
        }
        presenter.toggleFavorite(name: name, region: leagueRegion ?? "Unknown", image: image)
    }

    private func showNetworkError() {
        let alert = UIAlertController(
            title: "Network Connection",
            message: "You are offline. Please check your internet connection to view team details.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return (navigationController?.viewControllers.count ?? 0) > 1
    }
}

extension LeaguesDetailsViewController: LeaguesDetailsViewProtocol {
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.leaguesCompositionalLeaguesCollectionView.alpha = 0
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            UIView.animate(withDuration: 0.3) {
                self.leaguesCompositionalLeaguesCollectionView.alpha = 1.0
            }
        }
    }

    func refreshUI(upcoming: [MatchEvent], latest: [MatchEvent], teams: [Team]) {
        self.upcomingEvents = upcoming
        self.latestEvents = latest
        self.teams = teams
        DispatchQueue.main.async {
            self.leaguesCompositionalLeaguesCollectionView.reloadData()
        }
    }

    func updateFavoriteButton(isFavorite: Bool) {
        DispatchQueue.main.async {
            let imageName = isFavorite ? "heart.fill" : "heart"
            let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold)
            self.heartImage.image = UIImage(systemName: imageName, withConfiguration: config)
            self.heartImage.tintColor = isFavorite ? .systemRed : .white
        }
    }
}

extension LeaguesDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 3 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return upcomingEvents.isEmpty ? 1 : upcomingEvents.count
        case 1: return latestEvents.isEmpty  ? 1 : latestEvents.count
        case 2: return teams.isEmpty         ? 1 : teams.count
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if upcomingEvents.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateCollectionViewCell
                cell.configure(message: "No upcoming events")
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCollectionViewCell", for: indexPath) as! UpcomingCollectionViewCell
            cell.configure(with: upcomingEvents[indexPath.item])
            return cell

        case 1:
            if latestEvents.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateCollectionViewCell
                cell.configure(message: "No latest events")
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventCell", for: indexPath) as! LatestEventCollectionViewCell
            cell.configure(with: latestEvents[indexPath.item])
            return cell

        case 2:
            if teams.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateCollectionViewCell
                cell.configure(message: "No teams available")
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as! TeamsCollectionViewCell
            cell.configure(with: teams[indexPath.item])
            return cell

        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
            switch indexPath.section {
            case 0: header.titleLabel.text = "Upcoming Events"
            case 1: header.titleLabel.text = "Latest Events"
            case 2: header.titleLabel.text = "Teams"
            default: header.titleLabel.text = ""
            }
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 2, !teams.isEmpty else { return }
        let selectedTeam = teams[indexPath.item]

        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkCheck")
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                monitor.cancel()
                if path.status == .satisfied {
                    if let teamDetailsVC = self?.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsVC") as? TeamDetailsViewController {
                        teamDetailsVC.teamId = selectedTeam.teamKey
                        teamDetailsVC.hidesBottomBarWhenPushed = true
                        self?.navigationController?.pushViewController(teamDetailsVC, animated: true)
                    }
                } else {
                    self?.showNetworkError()
                }
            }
        }
        monitor.start(queue: queue)
    }
}

extension LeaguesDetailsViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return self.upcomingEvents.isEmpty ? self.createEmptyStateSection() : self.createUpcomingEventsSection()
            case 1: return self.latestEvents.isEmpty   ? self.createEmptyStateSection() : self.createVerticalLatestEventsSection()
            case 2: return self.teams.isEmpty          ? self.createEmptyStateSection() : self.createHorizontalTeamsSection()
            default: return self.createEmptyStateSection()
            }
        }
    }

    private func createUpcomingEventsSection() -> NSCollectionLayoutSection {
        let item  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 20, trailing: 16)
        section.boundarySupplementaryItems = [createHeaderSupplementaryItem()]
        return section
    }

    private func createVerticalLatestEventsSection() -> NSCollectionLayoutSection {
        let item  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeaderSupplementaryItem()]
        return section
    }

    private func createHorizontalTeamsSection() -> NSCollectionLayoutSection {
        let item  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(100), heightDimension: .absolute(130)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 20, trailing: 16)
        section.boundarySupplementaryItems = [createHeaderSupplementaryItem()]
        return section
    }

    private func createEmptyStateSection() -> NSCollectionLayoutSection {
        let item  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 20, trailing: 16)
        section.boundarySupplementaryItems = [createHeaderSupplementaryItem()]
        return section
    }

    private func createHeaderSupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

class EmptyStateCollectionViewCell: UICollectionViewCell {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(message: String) {
        messageLabel.text = message
    }
}
