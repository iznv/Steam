import Foundation

class StatisticsViewModel: BaseControllerViewModel {
    
    // MARK: - Errors
    
    enum Error: Swift.Error {
        
        case noSchema
        
    }
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties

    private let appId: Int
    
    private let steamId: String
    
    private var schema: AvailableGameStats?
    
    private var stats: UserStatsForGamePlayerStats?
    
    // MARK: - Events
    
    var didGetData: (() -> Void)?
    
    var didGetNoData: (() -> Void)?

    // MARK: - Cells View Models
    
    var progressViewModel: GameProgressCellViewModel? {
        guard let total = schema?.achievements?.count else { return nil }
        guard let achieved = stats?.achievements?.filter({ $0.achieved == 1 }).count else { return nil }

        return GameProgressCellViewModel(achieved: achieved, total: total)
    }
    
    var achievementsViewModel: TitleDisclosureCellViewModel? {
        guard schema?.achievements != nil else { return nil }
        return TitleDisclosureCellViewModel(title: R.string.localizable.gameStatisticsAchievements())
    }
    
    var statsViewModel: TitleDisclosureCellViewModel? {
        guard schema?.stats != nil else { return nil }
        return TitleDisclosureCellViewModel(title: R.string.localizable.gameStatisticsStats())
    }

    // MARK: - Services
    
    private let steamUserStatsService = SteamUserStatsService()

    // MARK: - Init

    init(appId: Int,
         steamId: String) {
        
        self.appId = appId
        self.steamId = steamId
    }

}

// MARK: - Public

extension StatisticsViewModel {
    
    func loadData() {
        schema = nil
        stats = nil

        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        steamUserStatsService.getSchemaForGame(appId: appId) { [weak self] result in
            switch result {
            case let .success(schema):
                self?.schema = schema
                if schema?.isEmpty == true {
                    self?.didGetNoData?()
                }
            case let .failure(error):
                self?.handle(error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        steamUserStatsService.getUserStatsForGame(steamId: steamId, appId: appId) { [weak self] result in
            switch result {
            case let .success(stats):
                if let stats = stats {
                    self?.stats = stats
                } else {
                    self?.handle(Error.noSchema)
                }
            case let .failure(error):
                self?.handle(error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .global(qos: .userInitiated)) { [weak self] in
            guard self?.schema?.isEmpty == false else { return }
            guard self?.stats != nil else { return }
            
            self?.didGetData?()
        }
    }
    
}
