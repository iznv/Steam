import Foundation

struct FriendCellViewModel {
    
    // MARK: - Properties
    
    let steamId: String

    let userPicUrl: URL?

    let realName: String?
    
    let userName: String
    
    // MARK: - Init
    
    init(steamId: String,
         userPicUrl: String,
         realName: String?,
         userName: String) {
        
        self.steamId = steamId
        self.userPicUrl = URL(string: userPicUrl)
        self.realName = realName
        self.userName = userName
    }
    
}
