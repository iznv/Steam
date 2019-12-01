import TableKit
import Utils

class CustomStatsViewController: BaseTableViewController<CustomStatsViewModel> {

    // MARK: - Properties
    
    lazy var tableDirector = TableDirector(tableView: tableView)
    
    // MARK: - Output
    
    var didSelectAll: (() -> Void)?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enableTheme(for: view)
        
        navigationItem.title = R.string.localizable.stats()
        
        configureTableView()
    }

    // MARK: - Table
    
    override func configureTableView() {
        let sections = viewModel.stats.map { section(stat: $0) }
        tableDirector.replace(with:
            sections +
            [separatorSection] +
            [allSection] +
            [separatorSection]
        )
    }
    
}

// MARK: - Themeable

extension CustomStatsViewController: Themeable {
    
    func apply(theme: Theme) {
        tableView.backgroundColor = theme.primaryBackgroundColor
    }
    
}

// MARK: - Table

private extension CustomStatsViewController {
    
    // MARK: - Sections
    
    var allSection: TableSection {
        return TableSection(onlyRows: [
            TableRow<TitleDisclosureCell>(item: viewModel.allViewModel)
                .on(.click) { [weak self] _ in
                    self?.didSelectAll?()
                }
        ])
    }
    
    func section(stat: CustomStatistics) -> TableSection {
        return TableSection(onlyRows: [
            headerRow(stat: stat),
            valuesRow(stat: stat)
        ])
    }
    
    var separatorSection: TableSection {
        return TableSection(onlyRows: [EmptyRow(height: CGFloat.sectionsSpacing)])
    }
    
    // MARK: - Rows
    
    func headerRow(stat: CustomStatistics) -> Row {
        return TableRow<CustomStatHeaderCell>(item:
            CustomStatHeaderCellViewModel(icon: stat.icon, title: stat.title)
        )
    }
    
    func valuesRow(stat: CustomStatistics) -> Row {
        return TableRow<TitleValueCollectionCell>(item:
            TitleValueCollectionCellViewModel(items: stat.items, valueFont: .medium16())
        )
    }

}
