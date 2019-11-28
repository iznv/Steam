import StatefulViewController
import TableKit
import Utils

class StatCompareViewController: BaseTableViewController<StatCompareViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let headerHeight: CGFloat = 50
        
    }
    
    // MARK: - Views
    
    private let headerView: CompareHeaderView = {
        let headerView = CompareHeaderView()
        headerView.value1 = R.string.localizable.user()
        headerView.value2 = R.string.localizable.you()
        return headerView
    }()

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)

    private lazy var stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: self)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTheme(for: view)

        bind()
        loadMyStats()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            section
        ])
    }
    
}

// MARK: - Themeable

extension StatCompareViewController: Themeable {
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.primaryBackgroundColor
    }
    
}

// MARK: - DefaultStatesDelegate

extension StatCompareViewController: DefaultStatesDelegate {
    
    func didTapRetry(view: CustomStateView) {
        loadMyStats()
    }
    
}

// MARK: - Binding

private extension StatCompareViewController {
    
    func bind() {
        viewModel.didGetMyStats = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: .none) {
                    self?.reload()
                }
            }
        }
        
        viewModel.didGetNoStats = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: ViewState.empty)
            }
        }
        
        bind(viewModel, to: stateMachine)
    }
    
}

// MARK: - Table

private extension StatCompareViewController {
    
    // MARK: - Sections
    
    var section: TableSection {
        let section = TableSection(headerView: headerView,
                                   footerView: nil,
                                   rows: rows)
        
        section.headerHeight = Constants.headerHeight
        section.footerHeight = .leastNonzeroMagnitude
        
        return section
    }
    
    // MARK: - Rows
    
    var rows: [Row] {
        return viewModel.statViewModels.map { TableRow<StatCompareCell>(item: $0) }
    }
    
}

// MARK: - Private

private extension StatCompareViewController {

    func loadMyStats() {
        stateMachine.transition(to: ViewState.loading) { [weak self] in
            self?.viewModel.loadMyStats()
        }
    }

}
