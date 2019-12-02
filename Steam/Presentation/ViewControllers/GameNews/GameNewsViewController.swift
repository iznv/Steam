import ApiKit
import StatefulViewController
import TableKit
import Utils

class GameNewsViewController: BaseTableViewController<GameNewsViewModel> {

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)
    
    private lazy var stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: self)

    // MARK: - Output
    
    var didTapArticle: ((String, String) -> Void)?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enableTheme(for: view)
        
        navigationItem.title = R.string.localizable.recentNews()
        
        bind()
        loadNews()
    }

    // MARK: - Table
    
    override func configureTableView() {
        tableDirector.replace(with: [
            section
        ])
    }

}

// MARK: - Themeable

extension GameNewsViewController: Themeable {
    
    func apply(theme: Theme) {
        tableView.backgroundColor = theme.primaryBackgroundColor
    }
    
}

// MARK: - DefaultStatesDelegate

extension GameNewsViewController: DefaultStatesDelegate {
    
    func didTapRetry(view: CustomStateView) {
        loadNews()
    }
    
}

// MARK: - Binding

private extension GameNewsViewController {
    
    func bind() {
        viewModel.didGetNews = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: .none) {
                    self?.reload()
                }
            }
        }
        
        viewModel.didGetNoNews = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: ViewState.empty)
            }
        }
        
        bind(viewModel, to: stateMachine)
    }
    
}

// MARK: - Table

private extension GameNewsViewController {
    
    // MARK: - Sections
    
    var section: TableSection {
        return TableSection(onlyRows: newsRows)
    }
    
    // MARK: - Rows
    
    var newsRows: [Row] {
        return viewModel.newsViewModels?.map {
            TableRow<NewsCell>(item: $0)
                .on(.click) { [weak self] options in
                    self?.didTapArticle?(options.item.title, options.item.htmlContents)
                }
        } ?? []
    }
    
}

// MARK: - Private

private extension GameNewsViewController {

    func loadNews() {
        stateMachine.transition(to: ViewState.loading) { [weak self] in
            self?.viewModel.loadNews()
        }
    }

}
