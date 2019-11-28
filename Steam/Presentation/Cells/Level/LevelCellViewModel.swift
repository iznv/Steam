import CoreGraphics

struct LevelCellViewModel {
    
    // MARK: - Properties

    let level: String
    
    let progress: CGFloat
    
    let progressString: String

    // MARK: - Init
    
    init(level: Int,
         xpTotal: Int,
         xpLeft: Int,
         xpCurrentLevel: Int) {
        
        self.level = R.string.localizable.profileLevelValue(String(level))
        
        let xpNextLevel = CGFloat(xpTotal + xpLeft)
        let xpFromCurrentLevelToNext = xpNextLevel - CGFloat(xpCurrentLevel)
        
        self.progress = 1 - CGFloat(xpLeft) / xpFromCurrentLevelToNext
        self.progressString = R.string.localizable.profileLevelXPProgress(String(xpTotal),
                                                                          String(Int(xpNextLevel)))
    }
    
}
