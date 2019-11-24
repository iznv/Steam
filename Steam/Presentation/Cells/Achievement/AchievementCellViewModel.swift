import Foundation

struct AchievementCellViewModel {
    
    // MARK: - Properties

    let picUrl: URL?
    
    let title: String
    
    let description: String?

    // MARK: - Init
    
    init(picUrl: String,
         title: String,
         description: String?) {
        
        self.picUrl = URL(string: picUrl)
        self.title = title
        self.description = description
    }
    
}
