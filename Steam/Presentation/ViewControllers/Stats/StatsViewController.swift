import TableKit
import Utils

class StatsViewController: BaseTableViewController<StatsViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = R.string.localizable.stats()
        
        configureTableView()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            section
        ])
    }

}

// MARK: - Table

private extension StatsViewController {
    
    // MARK: - Sections
    
    var section: TableSection {
        return TableSection(onlyRows: rows)
    }
    
    // MARK: - Rows
    
    var rows: [Row] {
        return viewModel.statsViewModels.map { TableRow<StatCell>(item: $0) }
    }
    
}
