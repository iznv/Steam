class ProfileViewModel {
    
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

extension ProfileViewModel {
    
    func loadProfileInfo() {
        ApiService.shared.getPlayerSummaries { response in
            print(response)
        }
    }
    
}

// MARK: - Actions

private extension ProfileViewModel {

    

}

// MARK: - Private

private extension ProfileViewModel {

    

}
