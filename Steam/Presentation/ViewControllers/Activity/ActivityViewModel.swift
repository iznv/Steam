class ActivityViewModel: BaseControllerViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    let steamId: String
    
    private let gamesType: GamesType

    private var games: [PlayerGame]?
    
    // MARK: - Computed Properties
    
    var title: String {
        switch gamesType {
        case .recent:
            return R.string.localizable.activity()
        case .owned:
            return R.string.localizable.games()
        }
    }
    
    // MARK: - Events
    
    var didGetGames: (() -> Void)?
    
    var didGetNoGames: (() -> Void)?

    // MARK: - Cells View Models
    
    var gamesViewModels: [PlayerGameCellViewModel]?
    
    // MARK: - Services
    
    private let steamPlayerService = SteamPlayerService()
    
    // MARK: - Init

    init(gamesType: GamesType,
         steamId: String? = nil) {

        self.gamesType = gamesType
        self.steamId = steamId ?? ApiService.Mocks.somePersonId
    }

}

// MARK: - Public

extension ActivityViewModel {
    
    func loadGames() {
        switch gamesType {
        case .recent:
            getRecentGames()
        case .owned:
            getOwnedGames()
        }
    }
    
}

// MARK: - Private

private extension ActivityViewModel {

    func makeCellsViewModels() {
        gamesViewModels = games?.map { PlayerGameCellViewModel(game: $0) }
    }
    
    func getRecentGames() {
        steamPlayerService.getRecentlyPlayedGames(steamId: steamId) { [weak self] in
            self?.handleGamesResult($0)
        }
    }
    
    func getOwnedGames() {
        steamPlayerService.getOwnedGames(steamId: steamId) { [weak self] in
            self?.handleGamesResult($0)
        }
    }
    
    func handleGamesResult(_ result: Result<[PlayerGame], ApiService.Error>) {
        switch result {
        case let .success(games):
            guard !games.isEmpty else {
                didGetNoGames?()
                return
            }
            
            self.games = games
            makeCellsViewModels()
            didGetGames?()
        case let .failure(error):
            handle(error)
        }
    }

}
