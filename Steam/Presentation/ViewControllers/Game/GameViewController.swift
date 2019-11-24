import StatefulViewController
import TableKit
import Utils

class GameViewController: BaseTableViewController<GameViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)

    private lazy var stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: self)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.statisticsBarButton(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openStatistics))
        
        bind()
        loadDetails()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            headerSection,
            infoSection
        ])
    }
    
}

// MARK: - DefaultStatesDelegate

extension GameViewController: DefaultStatesDelegate {
    
    func didTapRetry(view: CustomStateView) {
        loadDetails()
    }
    
}

// MARK: - Binding

private extension GameViewController {
    
    func bind() {
        viewModel.didGetDetails = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: .none) {
                    self?.reload()
                }
            }
        }
        
        bind(viewModel, to: stateMachine)
    }
    
}

// MARK: - Table

private extension GameViewController {
    
    // MARK: - Sections
    
    var headerSection: TableSection {
        return TableSection(onlyRows: [
            headerRow
        ].compactMap { $0 })
    }
    
    var infoSection: TableSection {
        return TableSection(onlyRows: [
            titleRow,
            genresRow,
            metacriticAndPlayersRow,
            releaseAndPublisherRow,
            descriptionRow
        ].compactMap { $0 })
    }
    
    // MARK: - Rows
    
    var headerRow: Row? {
        return viewModel.headerViewModel.map { TableRow<GameHeaderCell>(item: $0) }
    }
    
    var titleRow: Row? {
        return viewModel.titleViewModel.map { TableRow<TextCell>(item: $0) }
    }

    var metacriticAndPlayersRow: Row? {
        return viewModel.metacriticAndPlayersViewModel.map { TableRow<TitleValueCollectionCell>(item: $0) }
    }
    
    var releaseAndPublisherRow: Row? {
        return viewModel.releaseAndPublisherViewModel.map { TableRow<TitleValueCollectionCell>(item: $0) }
    }
    
    var genresRow: Row? {
        return viewModel.genresViewModel.map { TableRow<TextCell>(item: $0) }
    }
    
    var descriptionRow: Row? {
        return viewModel.descriptionViewModel.map { TableRow<TextCell>(item: $0) }
    }
    
}

// MARK: - Private

private extension GameViewController {

    func loadDetails() {
        stateMachine.transition(to: ViewState.loading) { [weak self] in
            self?.viewModel.loadDetails()
        }
    }
    
    @objc func openStatistics() {
        let statisticsViewController = StatisticsViewController(viewModel: .init(appId: viewModel.appId, steamId: viewModel.steamId))
        navigationController?.pushViewController(statisticsViewController, animated: true)
    }

}
