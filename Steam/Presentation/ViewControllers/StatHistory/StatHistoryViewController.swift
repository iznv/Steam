import StatefulViewController
import TableKit
import Utils

class StatHistoryViewController: BaseTableViewController<StatHistoryViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)

    private lazy var stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: nil)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTheme(for: view)
    
        navigationItem.title = R.string.localizable.history()

        bind()
        viewModel.loadHistory()
    }

    // MARK: - Table
    
    override func configureTableView() {
        var sections = [TableSection]()
        
        if viewModel.hasNotZeroData {
            sections.append(graphSection)
        }
        
        sections.append(historySection)
        
        tableDirector.replace(with: sections)
    }

}

// MARK: - Themeable

extension StatHistoryViewController: Themeable {
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.primaryBackgroundColor
    }
    
}

// MARK: - Binding

private extension StatHistoryViewController {
    
    func bind() {
        viewModel.didGetHistory = { [weak self] in
            DispatchQueue.main.async {
                self?.reload()
            }
        }
        
        viewModel.didGetNoHistory = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: ViewState.empty)
            }
        }
    }
    
}

// MARK: - Table

private extension StatHistoryViewController {
    
    // MARK: - Sections
    
    var graphSection: TableSection {
        return TableSection(onlyRows:
            [EmptyRow(height: CGFloat.sectionsSpacing)] +
            [graphRow] +
            [EmptyRow(height: CGFloat.sectionsSpacing)]
        )
    }
    
    var historySection: TableSection {
        return TableSection(onlyRows:
            historyRows
        )
    }
    
    // MARK: - Rows
    
    var graphRow: Row {
        return TableRow<GraphCell>(item: viewModel.graphViewModel)
    }
    
    var historyRows: [Row] {
        return viewModel.historyViewModels.map { TableRow<StatCell>(item: $0) }
    }
    
}
