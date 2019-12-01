import TableKit
import Utils

class AchievementsViewController: BaseTableViewController<AchievementsViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTheme(for: view)

        navigationItem.title = R.string.localizable.achievements()
        
        configureTableView()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            achievedSection,
            notAchievedSection
        ].compactMap { $0 })
    }

}

// MARK: - Themeable

extension AchievementsViewController: Themeable {
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.primaryBackgroundColor
    }
    
}

// MARK: - Table

private extension AchievementsViewController {
    
    // MARK: - Sections
    
    var achievedSection: TableSection? {
        guard !achievedRows.isEmpty else { return nil }
        
        return TableSection(onlyRows:
            [EmptyRow(height: CGFloat.sectionsSpacing)] +
            [achievedHeaderRow] +
            achievedRows
        )
    }
    
    var notAchievedSection: TableSection? {
        guard !notAchievedRows.isEmpty else { return nil }
        
        return TableSection(onlyRows:
            [EmptyRow(height: CGFloat.sectionsSpacing)] +
            [notAchievedHeaderRow] +
            notAchievedRows +
            [EmptyRow(height: CGFloat.sectionsSpacing)]
        )
    }
    
    // MARK: - Rows
    
    var achievedHeaderRow: Row {
        return TableRow<TextCell>(item: viewModel.achievedHeaderViewModel)
    }
    
    var notAchievedHeaderRow: Row {
        return TableRow<TextCell>(item: viewModel.notAchievedHeaderViewModel)
    }
    
    var achievedRows: [Row] {
        return viewModel.achievedViewModels.map { TableRow<AchievementCell>(item: $0) }
    }
    
    var notAchievedRows: [Row] {
        return viewModel.notAchievedViewModels.map { TableRow<AchievementCell>(item: $0) }
    }
    
}
