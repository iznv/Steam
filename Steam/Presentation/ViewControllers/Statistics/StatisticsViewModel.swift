import Foundation

class StatisticsViewModel: BaseControllerViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    var schema: AvailableGameStats?
    
    var stats: UserStatsForGamePlayerStats?

    let appId: Int
    
    private let steamId: String
    
    // MARK: - Events
    
    var didGetData: (() -> Void)?
    
    var didGetNoData: (() -> Void)?

    // MARK: - Cells View Models
    
    var progressViewModel: GameProgressCellViewModel? {
        guard let total = schema?.achievements?.count else { return nil }
        let achieved = stats?.achievements?.filter({ $0.achieved == 1 }).count ?? 0

        return GameProgressCellViewModel(achieved: achieved, total: total)
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
            case let .failure(error):
                self?.handle(error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        steamUserStatsService.getUserStatsForGame(steamId: steamId, appId: appId) { [weak self] result in
            switch result {
            case let .success(stats):
                self?.stats = stats
            case let .failure(error):
                self?.handle(error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .global(qos: .userInitiated)) { [weak self] in
            guard let self = self else { return }
            
            if self.schema != nil, self.schema?.isEmpty == false {
                self.didGetData?()
            } else {
                self.didGetNoData?()
            }
        }
    }
    
}
