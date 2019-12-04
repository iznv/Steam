import StatefulViewController
import TableKit
import Utils
import UIScrollView_InfiniteScroll

class GamesViewController: BaseViewController<GamesViewModel> {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let loadingIndicatorFrame = CGRect(x: 0, y: 0, width: 80, height: 80)
        
        static let infiniteScrollTriggerOffset: CGFloat = 2000
        
        static let debouncerDelay: TimeInterval = 0.3
        
    }
    
    // MARK: - Views

    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.delegate = self
        bar.searchBarStyle = .minimal
        return bar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Properties
    
    private lazy var tableDirector = TableDirector(tableView: tableView)

    private lazy var stateMachine = ViewStateMachine(view: view, defaultStatesDelegate: self)
    
    private lazy var searchDebouncer = Debouncer(delay: Constants.debouncerDelay) { [weak self] in
        guard let self = self else { return }
        self.viewModel.search(query: self.searchBar.text)
    }

    // MARK: - Output
    
    var didTapGame: ((Int) -> Void)?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTheme(for: view)

        navigationItem.title = R.string.localizable.gamesTabTitle()
        
        
        tableView.addInfiniteScroll { [weak self] tableView in
            self?.viewModel.loadNextPage()
        }

        tableView.infiniteScrollTriggerOffset = Constants.infiniteScrollTriggerOffset
        
        tableView.infiniteScrollIndicatorView = CustomLoadingIndicator(frame: Constants.loadingIndicatorFrame)
        
        bind()
        loadGames(animated: false)
    }
    
    // MARK: - Subviews
    
    override func addViews() {
        view.addSubviews(
            searchBar,
            tableView
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureSearchBarConstraints()
        configureTableViewConstraints()
    }

}

// MARK: - Themeable

extension GamesViewController: Themeable {
    
    func apply(theme: Theme) {
        tableView.backgroundColor = theme.primaryBackgroundColor
        view.backgroundColor = theme.primaryBackgroundColor
        searchBar.tintColor = theme.accentColor
        searchBar.setSearchField(textColor: theme.primaryTextColor)
        searchBar.keyboardAppearance = theme.keyboardAppearance
    }
    
}

// MARK: - UISearchBarDelegate

extension GamesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDebouncer.call()
    }
    
}

// MARK: - DefaultStatesDelegate

extension GamesViewController: DefaultStatesDelegate {
    
    func didTapRetry(view: CustomStateView) {
        loadGames()
    }
    
}

// MARK: - Binding

private extension GamesViewController {
    
    func bind() {
        viewModel.didGetGames = { [weak self] viewModels in
            let gamesRows = self?.gamesRows(for: viewModels) ?? []
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: .none, animated: false)
                self?.configureTableView(rows: gamesRows)
                self?.tableView.layoutIfNeeded()
                self?.tableView.contentOffset = .zero
            }
        }
        
        viewModel.didGetNoGames = { [weak self] in
            DispatchQueue.main.async {
                self?.stateMachine.transition(to: ViewState.empty)
            }
        }
        
        viewModel.didGetNextPage = { [weak self] viewModels in
            let gamesRows = self?.gamesRows(for: viewModels) ?? []
            DispatchQueue.main.async {
                self?.tableDirector.sections.last?.append(rows: gamesRows)
                self?.tableDirector.reload()
                self?.tableView.finishInfiniteScroll()
            }
        }
        
        bind(viewModel, to: stateMachine)
    }
    
}

// MARK: - TableView

private extension GamesViewController {
    
    func configureTableView(rows: [Row]) {
        tableDirector.replace(with: [TableSection(onlyRows: rows)])
    }
    
    // MARK: - Sections
    
    func gamesRows(for viewModels: [GameCellViewModel]) -> [Row] {
        return viewModels
            .map {
                TableRow<GameCell>(item: $0)
                    .on(.click) { [weak self] options in
                        self?.view.endEditing(true)
                        self?.didTapGame?(Int(options.item.appId))
                    }
            }
    }
    
}

// MARK: - Constraints

private extension GamesViewController {

    func configureSearchBarConstraints() {
        searchBar.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    func configureTableViewConstraints() {
        tableView.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }

}

// MARK: - Private

private extension GamesViewController {

    func loadGames(animated: Bool = true) {
        stateMachine.transition(to: ViewState.loading, animated: animated) { [weak self] in
            self?.viewModel.loadGames()
        }
    }

}
