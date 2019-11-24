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

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = R.string.localizable.statistics()
        
        bind()
        loadData()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            progressSection,
            itemsSection
        ])
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
            self?.stateMachine.transition(to: ViewState.empty)
        }
        
        bind(viewModel, to: stateMachine)
    }
    
}

// MARK: - Table

private extension StatisticsViewController {
    
    // MARK: - Sections
    
    var progressSection: TableSection {
        return TableSection(onlyRows: [
            achievementProgressRow
        ].compactMap { $0 })
    }
    
    var itemsSection: TableSection {
        return TableSection(onlyRows: itemsRows)
    }
    
    // MARK: - Rows
    
    var achievementProgressRow: Row? {
        return viewModel.progressViewModel.map { TableRow<GameProgressCell>(item: $0) }
    }
    
    var itemsRows: [Row] {
        return [
            viewModel.achievementsViewModel.map {
                TableRow<TitleDisclosureCell>(item: $0)
                    .on(.click) { [weak self] _ in
                        self?.openAchievements()
                    }
            },
            viewModel.statsViewModel.map { TableRow<TitleDisclosureCell>(item: $0) }
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
        guard let schemaAchievements = viewModel.schema?.achievements else { return }
        
        let achievementsViewController = AchievementsViewController(viewModel: .init(schemaAchievements: schemaAchievements,
                                                                                     achievements: viewModel.stats?.achievements ?? []))
        navigationController?.pushViewController(achievementsViewController, animated: true)
    }

}
