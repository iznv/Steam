import Foundation

class ProfileViewModel: BaseControllerViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    private enum Mocks {
        
        
        
    }
    
    // MARK: - Properties

    private var player: Player?
    
    private var badgesResponse: BadgesResponse?
    
    private var groupsCount: Int?
    
    // MARK: - Event
    
    var didGetProfile: (() -> Void)?
    
    // MARK: - Cells View Models
    
    var realNameViewModel: TextCellViewModel? {
        return realName.map { TextCellViewModel(text: $0) }
    }
    
    var userNameViewModel: TextCellViewModel? {
        return userName.map { TextCellViewModel(text: $0) }
    }
    
    var createdDateViewModel: TextCellViewModel? {
        return createdDate.map { TextCellViewModel(text: $0) }
    }
    
    var countryViewModel: CountryCellViewModel? {
        return countryCode.map { CountryCellViewModel(countryCode: $0) }
    }
    
    var userPicViewModel: UserPicStatusCellViewModel? {
        return player.map { UserPicStatusCellViewModel(userPicUrl: $0.avatarFull) }
    }
    
    var userStatusViewModel: TextCellViewModel? {
        return player.map { TextCellViewModel(text: $0.personaState.title) }
    }
    
    var levelViewModel: LevelCellViewModel? {
        return badgesResponse.map {
            LevelCellViewModel(level: $0.playerLevel,
                               xpTotal: $0.playerXP,
                               xpLeft: $0.playerXPNeededToLevelUp,
                               xpCurrentLevel: $0.playerXPNeededCurrentLevel)
        }
    }
    
    var valuesViewModel: TitleValueCollectionCellViewModel? {
        var items = [TitleValueItem]()
        
        if let badges = badgesResponse?.badges, !badges.isEmpty {
            items.append(TitleValueItem(title: R.string.localizable.profileBadges(), value: badges.count))
        }
        
        if let groupsCount = groupsCount, groupsCount > 0 {
            items.append(TitleValueItem(title: R.string.localizable.profileGroups(), value: groupsCount))
        }
        
        return items.isEmpty ? nil : TitleValueCollectionCellViewModel(items: items)
    }
    
    let gamesViewModel = TitleDisclosureCellViewModel(title: R.string.localizable.profileItemGames())
    
    let friendsViewModel = TitleDisclosureCellViewModel(title: R.string.localizable.profileItemFriends())

    // MARK: - Computed Properties
    
    private var realName: String? {
        return player?.realName
    }
    
    private var userName: String? {
        return player?.personaName
    }
    
    private var createdDate: String? {
        guard let player = player else { return nil }
        let date = DateFormatter.commomDateFormatter.string(from: player.timeCreated)
        return R.string.localizable.profileCreatedDate(date)
    }
    
    private var countryCode: String? {
        return player?.locCountryCode
    }

    // MARK: - Services
    
    private let steamUserService = SteamUserService()
    
    private let steamPlayerService = SteamPlayerService()

    // MARK: - Init

    override init() {
        
    }

}

// MARK: - Public

extension ProfileViewModel {
    
    func loadUserProfile() {
        player = nil
        badgesResponse = nil
        groupsCount = nil
        
        let steamId = ApiService.Mocks.somePersonId
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        steamUserService.getUserProfile(steamId: steamId) { [weak self] result in
            switch result {
            case let .success(players):
                self?.player = players.first
            case let .failure(error):
                self?.handle(error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        steamPlayerService.getBadges(steamId: steamId) { [weak self] result in
            switch result {
            case let .success(badgesResponse):
                self?.badgesResponse = badgesResponse
            case let .failure(error):
                self?.handle(error)
            }
            
            dispatchGroup.leave()
        }
                
        dispatchGroup.enter()
        steamUserService.getUserGroupList(steamId: steamId) { [weak self] result in
            switch result {
            case let .success(groups):
                self?.groupsCount = groups.count
            case let .failure(error):
                self?.handle(error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard self?.player != nil else { return }
            guard self?.badgesResponse != nil else { return }
            guard self?.groupsCount != nil else { return }
            
            self?.didGetProfile?()
        }
    }
    
}

// MARK: - Actions

private extension ProfileViewModel {

    

}

// MARK: - Private

private extension ProfileViewModel {

    

}
