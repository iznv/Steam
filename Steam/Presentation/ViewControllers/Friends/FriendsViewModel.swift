import ApiKit
import SteamKit

class FriendsViewModel: BaseControllerViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    private let steamId: String

    private var friends: [Friend]?
    
    private var summaries: [Player]?
    
    // MARK: - Events
    
    var didGetFriends: (() -> Void)?
    
    var didGetNoFriends: (() -> Void)?

    // MARK: - Cells View Models
    
    var friendViewModels: [FriendCellViewModel]?
    
    // MARK: - Services
    
    private let steamUserService = SteamUserService()
    
    // MARK: - Init

    init(steamId: String) {
        self.steamId = steamId
    }

}

// MARK: - Public

extension FriendsViewModel {
    
    func loadFriends() {
        friends = nil
        summaries = [Player]()
        
        steamUserService.getFriendList(steamId: steamId) { [weak self] result in
            switch result {
            case let .success(friends):
                self?.friends = friends
                self?.loadFriendsProfiles()
            case let .failure(error):
                self?.handle(error)
            }
        }
    }
    
}

// MARK: - Private

private extension FriendsViewModel {

    func loadFriendsProfiles() {
        guard let friends = friends else { return }
        
        guard !friends.isEmpty else {
            didGetNoFriends?()
            return
        }
        
        steamUserService.getPlayerSummaries(steamIds: friends.map { $0.steamId }) { [weak self] result in
            switch result {
            case let .success(summaries):
                self?.summaries = summaries
                self?.makeCellsViewModels()
                self?.didGetFriends?()
            case let .failure(error):
                self?.handle(error)
            }
        }
    }
    
    func makeCellsViewModels() {
        guard let friends = friends else { return }
        guard let summaries = summaries else { return }
        
        friendViewModels = friends.compactMap { friend in
            guard let summary = summaries.first(where: { $0.steamId == friend.steamId }) else { return nil }
            return FriendCellViewModel(steamId: summary.steamId,
                                       userPicUrl: summary.avatarFull,
                                       realName: summary.realName,
                                       userName: summary.personaName)
        }
    }

}
