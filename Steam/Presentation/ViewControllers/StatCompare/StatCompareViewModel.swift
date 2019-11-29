import Foundation

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
        
        return schemaStats.compactMap { schemaStat in
            let value1 = Int(stats.first(where: { $0.name == schemaStat.name })?.value ?? 0)
            let value2 = Int(myStats.first(where: { $0.name == schemaStat.name })?.value ?? 0)
            return StatCompareCellViewModel(title: schemaStat.title,
                                            value1: NumberFormatter.common.string(from: NSNumber(value: value1)),
                                            value2: NumberFormatter.common.string(from: NSNumber(value: value2)),
                                            whoWin: Win.compare(value1: value1, value2: value2))
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
        guard let steamId = authService.steamId else { return }
        
        myStats = nil

        steamUserStatsService.getUserStatsForGame(steamId: steamId, appId: appId) { [weak self] result in
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
