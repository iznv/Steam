import Foundation

struct UserPicStatusCellViewModel {
    
    // MARK: - Properties

    let userPicUrl: URL?
    
    // MARK: - Init
    
    init(userPicUrl: String) {
        self.userPicUrl = URL(string: userPicUrl)
    }
    
}
