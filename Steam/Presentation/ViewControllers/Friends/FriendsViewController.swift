import StatefulViewController
import TableKit
import Utils

class FriendsViewController: BaseTableViewController<FriendsViewModel> {

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)

    private lazy var stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: self)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTheme(for: view)
        
        navigationItem.title = R.string.localizable.friends()

        bind()
        loadFriends()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            section
        ])
    }

}

// MARK: - Themeable

extension FriendsViewController: Themeable {
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.primaryBackgroundColor
    }
    
}

// MARK: - DefaultStatesDelegate

extension FriendsViewController: DefaultStatesDelegate {
    
    func didTapRetry(view: CustomStateView) {
        loadFriends()
    }
    
}

// MARK: - Binding

private extension FriendsViewController {
    
    func bind() {
        viewModel.didGetFriends = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: .none) {
                    self?.reload()
                }
            }
        }
        
        viewModel.didGetNoFriends = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: ViewState.empty)
            }
        }
        
        bind(viewModel, to: stateMachine)
    }
    
}

// MARK: - Table

private extension FriendsViewController {
    
    // MARK: - Sections
    
    var section: TableSection {
        return TableSection(onlyRows: friendRows)
    }
    
    // MARK: - Rows
    
    var friendRows: [Row] {
        guard let friendViewModels = viewModel.friendViewModels else { return [] }
        return friendViewModels.map { friend in
            TableRow<FriendCell>(item: friend)
                .on(.click) { [weak self] _ in
                    let profileViewController = ProfileViewController(viewModel: .init(steamId: friend.steamId))
                    self?.navigationController?.pushViewController(profileViewController, animated: true)
                }
        }
    }
    
}

// MARK: - Private

private extension FriendsViewController {
    
    func loadFriends() {
        stateMachine.transition(to: ViewState.loading) { [weak self] in
            self?.viewModel.loadFriends()
        }
    }

}
