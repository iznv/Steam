import StatefulViewController
import TableKit
import Utils

class AchievementCompareViewController: BaseTableViewController<AchievementCompareViewModel> {
    
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

        bind()
        loadMyAchievements()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            section
        ])
    }
    
}

// MARK: - DefaultStatesDelegate

extension AchievementCompareViewController: DefaultStatesDelegate {
    
    func didTapRetry(view: CustomStateView) {
        loadMyAchievements()
    }
    
}

// MARK: - Binding

private extension AchievementCompareViewController {
    
    func bind() {
        viewModel.didGetMyAchievements = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: .none) {
                    self?.reload()
                }
            }
        }
        
        viewModel.didGetNoAchievements = { [weak self] in
            self?.stateMachine.transition(to: ViewState.empty)
        }
        
        bind(viewModel, to: stateMachine)
    }
    
}

// MARK: - Table

private extension AchievementCompareViewController {
    
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
        return viewModel.achievementViewModels.map { TableRow<StatCompareCell>(item: $0) }
    }
    
}

// MARK: - Private

private extension AchievementCompareViewController {

    func loadMyAchievements() {
        stateMachine.transition(to: ViewState.loading) { [weak self] in
            self?.viewModel.loadMyAchievements()
        }
    }

}
