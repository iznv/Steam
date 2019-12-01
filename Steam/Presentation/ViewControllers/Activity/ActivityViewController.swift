import StatefulViewController
import TableKit
import Utils

private enum ActivityViewState: String {
    
    case notAuthorized
    
}

class ActivityViewController: BaseTableViewController<ActivityViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Views

    private lazy var notAuthorizedView: UIView = {
        let view = CustomStateView()
        
        view.stateDescription = R.string.localizable.activityNotAuthorized()
        view.buttonTitle = R.string.localizable.login()
        
        view.didTapButton = { [weak self] in
            self?.didTapLogin?()
        }
        
        return view
    }()

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)
    
    private lazy var stateMachine: ViewStateMachine = {
        let stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: self)
        stateMachine[ActivityViewState.notAuthorized] = notAuthorizedView
        return stateMachine
    }()
    
    // MARK: - Output
    
    var didSelectGame: ((Int, String?) -> Void)?
    
    var didTapLogin: (() -> Void)?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTheme(for: view)

        navigationItem.title = viewModel.title

        bind()
        
        if viewModel.isLoggenIn {
            loadGames()
        } else {
            stateMachine.transition(to: ActivityViewState.notAuthorized, animated: false)
        }
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            section
        ])
    }

}

// MARK: - Themeable

extension ActivityViewController: Themeable {
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.primaryBackgroundColor
    }
    
}

// MARK: - DefaultStatesDelegate

extension ActivityViewController: DefaultStatesDelegate {
    
    func didTapRetry(view: CustomStateView) {
        loadGames()
    }
    
}

// MARK: - Binding

private extension ActivityViewController {
    
    func bind() {
        viewModel.didGetGames = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: .none) {
                    self?.reload()
                }
            }
        }
        
        viewModel.didGetNoGames = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: ViewState.empty)
            }
        }
        
        viewModel.didLogin = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: ViewState.loading, animated: false)
            }
        }
        
        viewModel.didLogout = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: ActivityViewState.notAuthorized)
            }
        }
        
        bind(viewModel, to: stateMachine)
    }
    
}

// MARK: - Table

private extension ActivityViewController {
    
    // MARK: - Sections
    
    var section: TableSection {
        return TableSection(onlyRows: rows)
    }
    
    // MARK: - Rows
    
    var rows: [Row] {
        guard let gamesViewModels = viewModel.gamesViewModels else { return [] }
        return gamesViewModels.map { game in
            TableRow<PlayerGameCell>(item: game)
                .on(.click) { [weak self] _ in
                    self?.didSelectGame?(game.appId, self?.viewModel.steamId)
                }
        }
    }
    
}

// MARK: - Private

private extension ActivityViewController {

    func loadGames() {
        stateMachine.transition(to: ViewState.loading) { [weak self] in
            self?.viewModel.loadGames()
        }
    }

}
