class ActivityViewModel: BaseControllerViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    private let steamId: String

    private var games: [PlayerGame]?
    
    // MARK: - Events
    
    var didGetGames: (() -> Void)?
    
    var didGetNoGames: (() -> Void)?

    // MARK: - Cells View Models
    
    var gamesViewModels: [PlayerGameCellViewModel]?
    
    // MARK: - Services
    
    private let steamPlayerService = SteamPlayerService()
    
    // MARK: - Init

    init(steamId: String? = nil) {
        self.steamId = steamId ?? ApiService.Mocks.somePersonId
    }

}

// MARK: - Public

extension ActivityViewModel {
    
    func loadGames() {
        steamPlayerService.getRecentlyPlayedGames(steamId: steamId) { [weak self] result in
            switch result {
            case let .success(games):
                guard !games.isEmpty else {
                    self?.didGetNoGames?()
                    return
                }
                
                self?.games = games
                self?.makeCellsViewModels()
                self?.didGetGames?()
            case let .failure(error):
                self?.handle(error)
            }
        }
    }
    
}

// MARK: - Private

private extension ActivityViewModel {

    func makeCellsViewModels() {
        gamesViewModels = games?.map { PlayerGameCellViewModel(game: $0) }
    }

}
