import ApiKit
import SteamKit

class AchievementCompareViewModel: BaseControllerViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    private let appId: Int

    private let schemaAchievements: [SchemaAchievement]
    
    private let achievements: [Achievement]
    
    private var myAchievements: [Achievement]?
    
    // MARK: - Events
    
    var didGetMyAchievements: (() -> Void)?
    
    var didGetNoAchievements: (() -> Void)?

    // MARK: - Cells View Models
    
    var achievementViewModels: [StatCompareCellViewModel] {
        guard let myAchievements = myAchievements else { return [] }
        
        let titleForAchievedStatus: (Int) -> String = {
            $0 == 1
                ? R.string.localizable.yes().lowercased()
                : R.string.localizable.no().lowercased()
        }
        
        return schemaAchievements.compactMap { schemaAchievement in
            let value1 = achievements.first(where: { $0.name == schemaAchievement.name })?.achieved ?? 0
            let value2 = myAchievements.first(where: { $0.name == schemaAchievement.name })?.achieved ?? 0
            
            let title = schemaAchievement.displayName.isEmpty ? schemaAchievement.name : schemaAchievement.displayName
            
            let whoWin = Win.compare(value1: value1,
                                     value2: value2,
                                     isDrawEqualsWinForBoth: true)
            
            return StatCompareCellViewModel(title: title,
                                            value1: titleForAchievedStatus(value1),
                                            value2: titleForAchievedStatus(value2),
                                            whoWin: whoWin)
        }
    }

    // MARK: - Services
    
    private let steamUserStatsService = SteamUserStatsService()
    
    private let authService = AuthService()

    // MARK: - Init

    init(appId: Int,
         schemaAchievements: [SchemaAchievement],
         achievements: [Achievement]) {
        
        self.appId = appId
        self.schemaAchievements = schemaAchievements
        self.achievements = achievements
    }

}

// MARK: - Public

extension AchievementCompareViewModel {
    
    func loadMyAchievements() {
        guard let steamId = authService.steamId else { return }
        
        myAchievements = nil

        steamUserStatsService.getUserStatsForGame(steamId: steamId, appId: appId) { [weak self] result in
            switch result {
            case let .success(stats):
                if let stats = stats, let myAchievements = stats.achievements {
                    self?.myAchievements = myAchievements
                    self?.didGetMyAchievements?()
                } else {
                    self?.didGetNoAchievements?()
                }
            case let .failure(error):
                self?.handle(error)
            }
        }
    }
    
}
