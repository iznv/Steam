class ActivityViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    private enum Mocks {
        
        
        
    }
    
    // MARK: - Properties

    

    // MARK: - Computed Properties
    
    // MARK: - Services

    private let playerService = PlayerService()
    
    // MARK: - Init

    init() {
        
    }

}

// MARK: - Public

extension ActivityViewModel {
    
    func loadActivity() {
        playerService.getRecentlyPlayedGames(steamId: ApiService.Mocks.myId) { response in
            print(response)
        }
        
        playerService.getOwnedGames(steamId: ApiService.Mocks.myId) { response in
            print(response)
        }
    }
    
}

// MARK: - Actions

private extension ActivityViewModel {

    

}

// MARK: - Private

private extension ActivityViewModel {

    

}
