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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.compareBarButton(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openAchievementCompare))

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

// MARK: - Table

private extension AchievementsViewController {
    
    // MARK: - Sections
    
    var achievedSection: TableSection? {
        guard !achievedRows.isEmpty else { return nil }
        
        return TableSection(onlyRows:
            [achievedHeaderRow] +
            achievedRows
        )
    }
    
    var notAchievedSection: TableSection? {
        guard !notAchievedRows.isEmpty else { return nil }
        
        return TableSection(onlyRows:
            [notAchievedHeaderRow] +
            notAchievedRows
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

// MARK: - Private

private extension AchievementsViewController {
    
    @objc func openAchievementCompare() {
        let statCompareViewController = AchievementCompareViewController(viewModel: .init(appId: viewModel.appId,
                                                                                          schemaAchievements: viewModel.schemaAchievements,
                                                                                          achievements: viewModel.achievements))
        navigationController?.pushViewController(statCompareViewController, animated: true)
    }
    
}
