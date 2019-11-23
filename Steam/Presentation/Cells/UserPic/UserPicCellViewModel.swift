import Foundation

struct UserPicCellViewModel {
    
    // MARK: - Properties

    let userPicUrl: URL?
    
    // MARK: - Init
    
    init(userPicUrl: String) {
        self.userPicUrl = URL(string: userPicUrl)
    }
    
}
