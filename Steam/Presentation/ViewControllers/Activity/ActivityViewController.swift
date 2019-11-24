import StatefulViewController
import TableKit
import Utils

class ActivityViewController: BaseTableViewController<ActivityViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)

    private lazy var stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: self)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.title

        bind()
        loadGames()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            section
        ])
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
            self?.stateMachine.transition(to: ViewState.empty)
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
                    guard let self = self else { return }
                    let gameViewController = GameViewController(viewModel: .init(appId: game.appId, steamId: self.viewModel.steamId))
                    self.navigationController?.pushViewController(gameViewController, animated: true)
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
