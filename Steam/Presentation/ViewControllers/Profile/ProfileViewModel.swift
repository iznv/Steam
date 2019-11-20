class ProfileViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    private enum Mocks {
        
        
        
    }
    
    // MARK: - Properties

    

    // MARK: - Computed Properties

    
    // MARK: - Services
    
    private let steamUserService = SteamUserService()

    // MARK: - Init

    init() {
        
    }

}

// MARK: - Public

extension ProfileViewModel {
    
    func loadUserProfile() {
        steamUserService.getUserProfile { profile in
            print(profile)
        }
    }
    
}

// MARK: - Actions

private extension ProfileViewModel {

    

}

// MARK: - Private

private extension ProfileViewModel {

    

}
