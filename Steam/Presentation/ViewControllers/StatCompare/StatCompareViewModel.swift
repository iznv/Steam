class StatCompareViewModel: BaseControllerViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    private let appId: Int

    private let schemaStats: [SchemaStat]
    
    private let stats: [Stat]
    
    private var myStats: [Stat]?
    
    // MARK: - Events
    
    var didGetMyStats: (() -> Void)?
    
    var didGetNoStats: (() -> Void)?

    // MARK: - Cells View Models
    
    var statViewModels: [StatCompareCellViewModel] {
        guard let myStats = myStats else { return [] }
        
        return zip(stats, myStats).compactMap { stat1, stat2 in
            guard let schemaStat = schemaStats.first(where: { $0.name == stat1.name }) else { return nil }
            let title = schemaStat.displayName.isEmpty ? schemaStat.name : schemaStat.displayName
            return StatCompareCellViewModel(title: title, value1: Int(stat1.value), value2: Int(stat2.value))
        }
    }

    // MARK: - Services
    
    private let steamUserStatsService = SteamUserStatsService()
    
    private let authService = AuthService()

    // MARK: - Init

    init(appId: Int,
         schemaStats: [SchemaStat],
         stats: [Stat]) {
        
        self.appId = appId
        self.schemaStats = schemaStats
        self.stats = stats
    }

}

// MARK: - Public

extension StatCompareViewModel {
    
    func loadMyStats() {
        myStats = nil

        steamUserStatsService.getUserStatsForGame(steamId: authService.steamId, appId: appId) { [weak self] result in
            switch result {
            case let .success(stats):
                if let stats = stats, let myStats = stats.stats {
                    self?.myStats = myStats
                    self?.didGetMyStats?()
                } else {
                    self?.didGetNoStats?()
                }
            case let .failure(error):
                self?.handle(error)
            }
        }
    }
    
}


// MARK: - Private

private extension StatCompareViewModel {

    

}
