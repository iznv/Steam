import SteamLogin
import TableKit
import Utils

class ProfileViewController: BaseTableViewController<ProfileViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    private enum Mocks {
        
        
        
    }
    
    // MARK: - Views

    

    // MARK: - Properties
    
    lazy var tableDirector = TableDirector(tableView: tableView)

    

    // MARK: - Computed Properties



    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = R.string.localizable.profileTabTitle()
        
        bind()

        viewModel.loadUserProfile()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            userPicSection,
            userInfoSection,
            levelSection,
            countersSection,
            itemsSection
        ])
    }
    
    // MARK: - Overrides

    

}

// MARK: - Binding

private extension ProfileViewController {
    
    func bind() {
        viewModel.didGetProfile = { [weak self] in
            self?.configureTableView()
        }
    }
    
}

// MARK: - Table

private extension ProfileViewController {
    
    // MARK: - Sections
    
    var userPicSection: TableSection {
        return TableSection(onlyRows: [
            userPicRow
        ].compactMap { $0 })
    }
    
    var userInfoSection: TableSection {
        return TableSection(onlyRows: [
            realNameRow,
            userNameRow,
            countryRow,
            userStatusRow,
            createdDateRow
        ].compactMap { $0 })
    }
    
    var levelSection: TableSection {
        return TableSection(onlyRows: [
            levelRow
        ].compactMap { $0 })
    }
    
    var countersSection: TableSection {
        return TableSection(onlyRows: [
            countersRow
        ].compactMap { $0 })
    }
    
    var itemsSection: TableSection {
        return TableSection(onlyRows:
            itemsRows
        )
    }
    
    // MARK: - Rows
    
    var userStatusRow: Row? {
        return viewModel.userStatusViewModel.map { TableRow<TextCell>(item: $0) }
    }
    
    var realNameRow: Row? {
        return viewModel.realNameViewModel.map { TableRow<TextCell>(item: $0) }
    }
    
    var userNameRow: Row? {
        return viewModel.userNameViewModel.map { TableRow<TextCell>(item: $0) }
    }
    
    var createdDateRow: Row? {
        return viewModel.createdDateViewModel.map { TableRow<TextCell>(item: $0) }
    }
    
    var countryRow: Row? {
        return viewModel.countryViewModel.map { TableRow<CountryCell>(item: $0) }
    }
    
    var countersRow: Row? {
        return viewModel.valuesViewModel.map { TableRow<TitleValueCollectionCell>(item: $0) }
    }
    
    var itemsRows: [Row] {
        return [
            TableRow<TitleDisclosureCell>(item: viewModel.gamesViewModel),
            TableRow<TitleDisclosureCell>(item: viewModel.friendsViewModel)
        ]
    }
    
    var userPicRow: Row? {
        return viewModel.userPicViewModel.map { TableRow<UserPicStatusCell>(item: $0) }
    }
    
    var levelRow: Row? {
        return viewModel.levelViewModel.map { TableRow<LevelCell>(item: $0) }
    }
    
}

// MARK: - Actions

private extension ProfileViewController {

    

}

// MARK: - Constraints

private extension ProfileViewController {

    

}

// MARK: - Private

private extension ProfileViewController {

    func login() {
        SteamLoginVC.login(from: self) { user, error in
            if let user = user {
                print(user)
            }
        }
    }

}
