import ApiKit
import StatefulViewController
import TableKit
import Utils

class StatisticsViewController: BaseTableViewController<StatisticsViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)

    private lazy var stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: self)
    
    // MARK: - Output
    
    var didTapAchievements: (([SchemaAchievement], [Achievement]) -> Void)?
    
    var didTapStats: (([SchemaStat], [Stat]) -> Void)?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTheme(for: view)
        
        navigationItem.title = R.string.localizable.statistics()
        
        bind()
        loadData()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            progressSection,
            itemsSection
        ].compactMap { $0 })
    }

}

// MARK: - Themeable

extension StatisticsViewController: Themeable {
    
    func apply(theme: Theme) {
        view.backgroundColor = theme.primaryBackgroundColor
    }
    
}

// MARK: - DefaultStatesDelegate

extension StatisticsViewController: DefaultStatesDelegate {
    
    func didTapRetry(view: CustomStateView) {
        loadData()
    }
    
}

// MARK: - Binding

private extension StatisticsViewController {
    
    func bind() {
        viewModel.didGetData = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: .none) {
                    self?.reload()
                }
            }
        }
        
        viewModel.didGetNoData = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: ViewState.empty)
            }
        }
        
        bind(viewModel, to: stateMachine)
    }
    
}

// MARK: - Table

private extension StatisticsViewController {
    
    // MARK: - Sections
    
    var progressSection: TableSection? {
        guard let achievementProgressRow = achievementProgressRow else { return nil }
        
        return TableSection(onlyRows: [
            EmptyRow(height: CGFloat.sectionsSpacing),
            achievementProgressRow,
            EmptyRow(height: CGFloat.sectionsSpacing)
        ].compactMap { $0 })
    }
    
    var itemsSection: TableSection {
        return TableSection(onlyRows: itemsRows)
    }
    
    // MARK: - Rows
    
    var achievementProgressRow: Row? {
        return viewModel.progressViewModel.map {
            TableRow<GameProgressCell>(item: $0)
                .on(.click) { [weak self] _ in
                    self?.openAchievements()
                }
            }
    }
    
    var itemsRows: [Row] {
        return [
            viewModel.statsViewModel.map {
                TableRow<TitleDisclosureCell>(item: $0)
                    .on(.click) { [weak self] _ in
                        self?.openStats()
                }
            }
        ].compactMap { $0 }
    }
    
}

// MARK: - Private

private extension StatisticsViewController {

    func loadData() {
        stateMachine.transition(to: ViewState.loading) { [weak self] in
            self?.viewModel.loadData()
        }
    }
    
    func openAchievements() {
        didTapAchievements?(viewModel.schema?.achievements ?? [],
                            viewModel.stats?.achievements ?? [])
    }
    
    func openStats() {
        didTapStats?(viewModel.schema?.stats ?? [],
                     viewModel.stats?.stats ?? [])
    }

}
