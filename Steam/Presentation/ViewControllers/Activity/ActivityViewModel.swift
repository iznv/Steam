class ActivityViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    private enum Mocks {
        
        
        
    }
    
    // MARK: - Properties

    

    // MARK: - Computed Properties

    

    // MARK: - Init

    init() {
        
    }

}

// MARK: - Public

extension ActivityViewModel {
    
    func loadActivity() {
        ApiService.shared.getRecentlyPlayedGames { response in
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
