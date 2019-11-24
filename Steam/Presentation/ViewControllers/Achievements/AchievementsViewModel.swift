class AchievementsViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    let appId: Int
    
    let schemaAchievements: [SchemaAchievement]
    
    let achievements: [Achievement]
    
    private let achivedAchievements: [SchemaAchievement]
    
    private let notAchivedAchievements: [SchemaAchievement]

    // MARK: - Cells View Models
    
    let achievedHeaderViewModel = TextCellViewModel(text: R.string.localizable.achievementsAchieved())
    
    let notAchievedHeaderViewModel = TextCellViewModel(text: R.string.localizable.achievementsNotAchieved())
    
    var achievedViewModels: [AchievementCellViewModel] {
        return achivedAchievements.compactMap { makeCellViewModel(achievement: $0) }
    }
    
    var notAchievedViewModels: [AchievementCellViewModel] {
        return notAchivedAchievements.compactMap { makeCellViewModel(achievement: $0) }
    }

    // MARK: - Init

    init(appId: Int,
         schemaAchievements: [SchemaAchievement],
         achievements: [Achievement]) {
        
        self.appId = appId
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
