import ApiKit
import SteamKit

class GamesViewModel: BaseControllerViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let fetchCount = 100
        
    }

    // MARK: - Properties

    private var games: [App]?
    
    private var query: String?
    
    private var offset = 0
    
    // MARK: - Events
    
    var didGetGames: (([GameCellViewModel]) -> Void)?

    var didGetNoGames: (() -> Void)?
    
    var didGetNextPage: (([GameCellViewModel]) -> Void)?
    
    // MARK: - Services
    
    private let steamAppsService = SteamAppsService()
    
    private let gamesService = GamesService()

    // MARK: - Init

}

// MARK: - Public

extension GamesViewModel {
    
    func loadNextPage() {
        gamesService.getGames(query: query,
                              count: Constants.fetchCount,
                              offset: offset) { [weak self] games in
                                
            let gamesViewModels = games.map { GameCellViewModel(appId: $0.appId, name: $0.name) }
            
            if self?.offset == 0 {
                self?.didGetGames?(gamesViewModels)
            } else {
                self?.didGetNextPage?(gamesViewModels)
            }

            self?.offset += Constants.fetchCount
        }
    }
    
    func search(query: String?) {
        self.query = query
        offset = 0
        loadNextPage()
    }

    func loadGames() {
        games = nil
        
        gamesService.getGames() { [weak self] savedGames in
            if savedGames.isEmpty {
                self?.getApps()
            } else {
                let gamesViewModels = savedGames.map { GameCellViewModel(appId: $0.appId, name: $0.name) }
                self?.offset += Constants.fetchCount
                self?.didGetGames?(gamesViewModels)
            }
        }
    }

}

// MARK: - Private

private extension GamesViewModel {

    func getApps() {
        steamAppsService.getAppList() { [weak self] result in
                    switch result {
                    case let .success(games):
                        if games.isEmpty {
                            self?.didGetNoGames?()
                        } else {
                            self?.gamesService.save(games: games) {
                                self?.loadGames()
                            }
                        }
                    case let .failure(error):
                        self?.handle(error)
                    }
                }
    }

}
