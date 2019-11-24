import CoreGraphics

struct GameProgressCellViewModel {
        
    // MARK: - Properties

    let progressValue: CGFloat
    
    let progressString: String
    
    // MARK: - Initialization
    
    init(achieved: Int,
         total: Int) {
        
        self.progressValue = CGFloat(achieved) / CGFloat(total)
        self.progressString = R.string.localizable.gameStatisticsAchievementProgressFormat(String(achieved), String(total))
    }
    
}
