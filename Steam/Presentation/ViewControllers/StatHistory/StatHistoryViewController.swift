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
        return TableSection(onlyRows: [graphRow])
    }
    
    var historySection: TableSection {
        return TableSection(onlyRows:
            [historyHeaderRow] +
            historyRows
        )
    }
    
    // MARK: - Rows
    
    var graphRow: Row {
        return TableRow<GraphCell>(item: viewModel.graphViewModel)
    }
    
    var historyHeaderRow: Row {
        return TableRow<TextCell>(item: viewModel.historyHeaderViewModel)
    }
    
    var historyRows: [Row] {
        return viewModel.historyViewModels.map { TableRow<StatCell>(item: $0) }
    }
    
}
