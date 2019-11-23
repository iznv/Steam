class ActivityViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    private enum Mocks {
        
        
        
    }
    
    // MARK: - Properties

    

    // MARK: - Computed Properties
    
    // MARK: - Services
    
    private let steamPlayerService = SteamPlayerService()
    
    // MARK: - Init

    init() {
        
    }

}

// MARK: - Public

extension ActivityViewModel {
    
    func loadActivity() {
        steamPlayerService.getRecentlyPlayedGames(steamId: ApiService.Mocks.somePersonId) { games in

        }
    }
    
}

// MARK: - Actions

private extension ActivityViewModel {

    

}

// MARK: - Private

private extension ActivityViewModel {

    

}
