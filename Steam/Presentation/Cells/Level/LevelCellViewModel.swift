import CoreGraphics

struct LevelCellViewModel {
    
    // MARK: - Properties

    let level: String
    
    let xpTotal: String
    
    let xpLeft: String
    
    let progress: CGFloat

    // MARK: - Init
    
    init(level: Int,
         xpTotal: Int,
         xpLeft: Int,
         xpCurrentLevel: Int) {
        
        self.level = R.string.localizable.profileLevelValue(String(level))
        self.xpTotal = R.string.localizable.profileLevelXPTotal(String(xpTotal))
        self.xpLeft = R.string.localizable.profileLevelXPLeft(String(xpLeft))
        
        let xpNextLevel = CGFloat(xpTotal + xpLeft)
        let xpFromCurrentLevelToNext = xpNextLevel - CGFloat(xpCurrentLevel)
        self.progress = 1 - CGFloat(xpLeft) / xpFromCurrentLevelToNext
    }
    
}
