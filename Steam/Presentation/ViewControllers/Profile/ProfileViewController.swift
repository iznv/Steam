import StatefulViewController
import TableKit
import Utils

private enum ProfileViewState: String {
    
    case notAuthorized
    
}

class ProfileViewController: BaseTableViewController<ProfileViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Views

    private lazy var notAuthorizedView: UIView = {
        let view = CustomStateView()
        
        view.stateDescription = R.string.localizable.profileNotAuthorized()
        view.buttonTitle = R.string.localizable.login()
        
        view.didTapButton = { [weak self] in
            self?.login()
        }
        
        return view
    }()

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)

    private lazy var stateMachine: ViewStateMachine = {
        let stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: self)
        stateMachine[ProfileViewState.notAuthorized] = notAuthorizedView
        return stateMachine
    }()

    // MARK: - Computed Properties



    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTheme(for: view)
        
        navigationItem.title = viewModel.isUserProfile ? R.string.localizable.profileTabTitle() : .empty
        
        bind()
        
        if viewModel.isUserProfile {
            showLogoutButton()
        }
        
        if viewModel.isLoggenIn {
            loadProfile()
        } else {
            stateMachine.transition(to: ProfileViewState.notAuthorized, animated: false)
        }
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            userPicSection,
            userInfoSection,
            countersSection,
            itemsSection
        ].compactMap { $0 })
    }

}

// MARK: - Themeable

extension ProfileViewController: Themeable {
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.primaryBackgroundColor
    }
    
}

// MARK: - DefaultStatesDelegate

extension ProfileViewController: DefaultStatesDelegate {
    
    func didTapRetry(view: CustomStateView) {
        loadProfile()
    }
    
}

// MARK: - Binding

private extension ProfileViewController {
    
    func bind() {
        viewModel.didGetProfile = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.navigationItem.title = self.viewModel.userName
                self.stateMachine.transition(to: .none) {
                    self.reload()
                }
            }
        }
        
        viewModel.didLogin = { [weak self] in
            self?.onLogin()
        }
        
        viewModel.didLogout = { [weak self] in
            self?.onLogout()
        }
        
        bind(viewModel, to: stateMachine)
    }
    
}

// MARK: - Table

private extension ProfileViewController {
    
    // MARK: - Sections
    
    var userPicSection: TableSection {
        return TableSection(onlyRows: [
            EmptyRow(height: CGFloat.sectionsSpacing),
            userPicRow
        ].compactMap { $0 })
    }
    
    var userInfoSection: TableSection {
        return TableSection(onlyRows: [
            EmptyRow(height: CGFloat.sectionsSpacing),
            realNameRow,
            EmptyRow(height: 4),
            countryRow,
            EmptyRow(height: CGFloat.sectionsSpacing),
            levelRow,
            EmptyRow(height: CGFloat.sectionsSpacing),
            statusAndCreatedRow
        ].compactMap { $0 })
    }
    
    var countersSection: TableSection? {
        guard let countersRow = countersRow else { return nil }
        
        return TableSection(onlyRows: [
            EmptyRow(height: CGFloat.sectionsSpacing),
            countersRow
        ])
    }
    
    var itemsSection: TableSection {
        return TableSection(onlyRows:
            [EmptyRow(height: CGFloat.sectionsSpacing)] +
            itemsRows +
            [EmptyRow(height: CGFloat.sectionsSpacing)]
        )
    }
    
    // MARK: - Rows
    
    var realNameRow: Row? {
        return viewModel.realNameViewModel.map { TableRow<TextCell>(item: $0) }
    }
    
    var countryRow: Row? {
        return viewModel.countryViewModel.map { TableRow<CountryCell>(item: $0) }
    }
    
    var statusAndCreatedRow: Row? {
        return viewModel.statusAndCreatedViewModel.map { TableRow<TitleValueCollectionCell>(item: $0) }
    }
    
    var countersRow: Row? {
        return viewModel.valuesViewModel.map { TableRow<TitleValueCollectionCell>(item: $0) }
    }
    
    var itemsRows: [Row] {
        return [
            TableRow<TitleDisclosureCell>(item: viewModel.activityViewModel)
                .on(.click) { [weak self] _ in
                    self?.openGames(gamesType: .recent)
                },
            TableRow<TitleDisclosureCell>(item: viewModel.gamesViewModel)
                .on(.click) { [weak self] _ in
                    self?.openGames(gamesType: .owned)
                },
            TableRow<TitleDisclosureCell>(item: viewModel.friendsViewModel)
                .on(.click) { [weak self] _ in
                    self?.openFriends()
                }
        ]
    }
    
    var userPicRow: Row? {
        return viewModel.userPicViewModel.map {
            TableRow<UserPicCell>(item: $0)
                .on(.click) { _ in
                    ThemeManager.toggleTheme()
                }
        }
    }
    
    var levelRow: Row? {
        return viewModel.levelViewModel.map { TableRow<LevelCell>(item: $0) }
    }
    
}

// MARK: - Actions

private extension ProfileViewController {

    func login() {
        let loginViewController = LoginViewController(viewModel: .init()).embeddedInNavigation
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
    }

}

// MARK: - Private

private extension ProfileViewController {
    
    func loadProfile() {
        stateMachine.transition(to: ViewState.loading) { [weak self] in
            self?.viewModel.loadUserProfile()
        }
    }
    
    func openGames(gamesType: GamesType) {
        guard let steamId = viewModel.steamId else { return }
        let friendsViewController = ActivityViewController(viewModel: .init(gamesType: gamesType, steamId: steamId))
        navigationController?.pushViewController(friendsViewController, animated: true)
    }
    
    func openFriends() {
        guard let steamId = viewModel.steamId else { return }
        let friendsViewController = FriendsViewController(viewModel: .init(steamId: steamId))
        navigationController?.pushViewController(friendsViewController, animated: true)
    }
    
    @objc func logout() {
        viewModel.logout()
    }
    
    func onLogin() {
        stateMachine.transition(to: ViewState.loading, animated: false)
        showLogoutButton()
    }
    
    func onLogout() {
        stateMachine.transition(to: ProfileViewState.notAuthorized)
        navigationItem.rightBarButtonItem = nil
    }
    
    func showLogoutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.logoutBarButton(), style: .plain, target: self, action: #selector(self.logout))
    }

}
