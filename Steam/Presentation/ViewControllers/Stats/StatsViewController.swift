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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.compareBarButton(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openStatCompare))

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
        return viewModel.statsViewModels.map {
            TableRow<StatCell>(item: $0)
                .on(.click) { [weak self] options in
                    self?.openStatHistory(name: options.item.name)
                }
        }
    }
    
}

// MARK: - Private

private extension StatsViewController {
    
    @objc func openStatCompare() {
        let statCompareViewController = StatCompareViewController(viewModel: .init(appId: viewModel.appId,
                                                                                   schemaStats: viewModel.schemaStats,
                                                                                   stats: viewModel.stats))
        navigationController?.pushViewController(statCompareViewController, animated: true)
    }
    
    func openStatHistory(name: String) {
        let statHistoryViewController = StatHistoryViewController(viewModel: .init(appId: viewModel.appId,
                                                                                   statName: name))
        navigationController?.pushViewController(statHistoryViewController, animated: true)
    }
    
}
