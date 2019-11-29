import ApiKit
import SteamKit

class ActivityViewModel: BaseControllerViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    var steamId: String?
    
    private let gamesType: GamesType

    private var games: [PlayerGame]?
    
    // MARK: - Events
    
    var didLogin: (() -> Void)?
    
    var didLogout: (() -> Void)?
    
    // MARK: - Computed Properties
    
    var title: String {
        switch gamesType {
        case .recent:
            return R.string.localizable.activity()
        case .owned:
            return R.string.localizable.games()
        }
    }
    
    var isLoggenIn: Bool {
        return authService.isLoggenIn
    }
    
    // MARK: - Events
    
    var didGetGames: (() -> Void)?
    
    var didGetNoGames: (() -> Void)?

    // MARK: - Cells View Models
    
    var gamesViewModels: [PlayerGameCellViewModel]?
    
    // MARK: - Services
    
    private let steamPlayerService = SteamPlayerService()
    
    private let authService = AuthService()
    
    private let notificationCenter = NotificationCenter.default
    
    // MARK: - Init

    init(gamesType: GamesType,
         steamId: String? = nil) {
        
        self.gamesType = gamesType
        
        super.init()
        
        let isUserProfile = steamId == nil

        self.steamId = isUserProfile ? authService.steamId : steamId
        
        if isUserProfile {
            observeAuthState()
        }
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
        guard let steamId = steamId else { return }
        
        steamPlayerService.getRecentlyPlayedGames(steamId: steamId) { [weak self] in
            self?.handleGamesResult($0)
        }
    }
    
    func getOwnedGames() {
        guard let steamId = steamId else { return }
        
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
    
    func observeAuthState() {
        notificationCenter.addObserver(forName: .didChangeAuthState,
                                       object: nil,
                                       queue: .main) { [weak self] _ in
            guard let self = self else { return }
            if self.authService.isLoggenIn {
                self.didLogin?()
                self.steamId = self.authService.steamId
                self.loadGames()
            } else {
                self.didLogout?()
            }
        }
    }

}
