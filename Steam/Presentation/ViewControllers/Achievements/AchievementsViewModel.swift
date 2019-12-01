import ApiKit

class AchievementsViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    let schemaAchievements: [SchemaAchievement]
    
    let achievements: [Achievement]
    
    private let achivedAchievements: [SchemaAchievement]
    
    private let notAchivedAchievements: [SchemaAchievement]
    
    private let steamId: String
    
    // MARK: - Computed Properties
    
    var canCompare: Bool {
        return authService.steamId != steamId
    }

    // MARK: - Cells View Models
    
    let achievedHeaderViewModel = TextCellViewModel(text: R.string.localizable.achievementsAchieved().uppercased(),
                                                    font: .bold17(),
                                                    color: { $0.primaryTextColor.withAlphaComponent(0.3) })
    
    let notAchievedHeaderViewModel = TextCellViewModel(text: R.string.localizable.achievementsNotAchieved().uppercased(),
                                                       font: .bold17(),
                                                       color: { $0.primaryTextColor.withAlphaComponent(0.3) })
    
    var achievedViewModels: [AchievementCellViewModel] {
        return achivedAchievements.compactMap { makeCellViewModel(achievement: $0) }
    }
    
    var notAchievedViewModels: [AchievementCellViewModel] {
        return notAchivedAchievements.compactMap { makeCellViewModel(achievement: $0) }
    }
    
    // MARK: - Services
    
    private let authService = AuthService()

    // MARK: - Init

    init(steamId: String,
         schemaAchievements: [SchemaAchievement],
         achievements: [Achievement]) {

        self.steamId = steamId
        self.schemaAchievements = schemaAchievements
        self.achievements = achievements
        
        let achieved = achievements.filter { $0.achieved == 1 }
                
        self.achivedAchievements = schemaAchievements.filter { schemaAchievement in
            achieved.contains(where: { schemaAchievement.name == $0.name })
        }
        
        self.notAchivedAchievements = schemaAchievements.filter { schemaAchievement in
            !achieved.contains(where: { schemaAchievement.name == $0.name })
        }
    }

}

// MARK: - Private

private extension AchievementsViewModel {

    func makeCellViewModel(achievement: SchemaAchievement) -> AchievementCellViewModel {
        return AchievementCellViewModel(picUrl: achievement.icon,
                                        title: achievement.displayName,
                                        description: achievement.description)
    }

}
