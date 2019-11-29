import Foundation

class ProfileViewModel: BaseControllerViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    private enum Mocks {
        
        
        
    }
    
    // MARK: - Properties
    
    var steamId: String?
    
    let isUserProfile: Bool

    private var player: Player?
    
    private var badgesResponse: BadgesResponse?
    
    private var groupsCount: Int?
    
    // MARK: - Computed Properties
    
    var isLoggenIn: Bool {
        return authService.isLoggenIn
    }
    
    // MARK: - Events
    
    var didGetProfile: (() -> Void)?
    
    var didLogin: (() -> Void)?
    
    var didLogout: (() -> Void)?
    
    // MARK: - Cells View Models
    
    var realNameViewModel: TextCellViewModel? {
        return realName.map { TextCellViewModel(text: $0, font: .medium26()) }
    }
    
    var countryViewModel: CountryCellViewModel? {
        return countryCode.map { CountryCellViewModel(countryCode: $0) }
    }
    
    var userPicViewModel: UserPicCellViewModel? {
        return player.map { UserPicCellViewModel(userPicUrl: $0.avatarFull) }
    }
    
    var levelViewModel: LevelCellViewModel? {
        guard let response = badgesResponse else { return nil }
        
        guard let playerLevel = response.playerLevel,
              let playerXP = response.playerXP,
              let playerXPNeededToLevelUp = response.playerXPNeededToLevelUp,
              let playerXPNeededCurrentLevel = response.playerXPNeededCurrentLevel else {
            return nil
        }
            
        return LevelCellViewModel(level: playerLevel,
                                  xpTotal: playerXP,
                                  xpLeft: playerXPNeededToLevelUp,
                                  xpCurrentLevel: playerXPNeededCurrentLevel)
    }
    
    var statusAndCreatedViewModel: TitleValueCollectionCellViewModel? {
        var items = [TitleValueItem]()
        
        if let state = player?.personaState.title {
            items.append(TitleValueItem(title: R.string.localizable.profileStatus(), value: state))
        }
        
        if let createdDate = createdDate {
            items.append(TitleValueItem(title: R.string.localizable.profileCreated(), value: createdDate))
        }
        
        return items.isEmpty ? nil : TitleValueCollectionCellViewModel(items: items)
    }
    
    var valuesViewModel: TitleValueCollectionCellViewModel? {
        var items = [TitleValueItem]()
        
        if let badges = badgesResponse?.badges, !badges.isEmpty {
            items.append(TitleValueItem(title: R.string.localizable.profileBadges(), value: String(badges.count)))
        }
        
        if let groupsCount = groupsCount, groupsCount > 0 {
            items.append(TitleValueItem(title: R.string.localizable.profileGroups(), value: String(groupsCount)))
        }
        
        return items.isEmpty ? nil : TitleValueCollectionCellViewModel(items: items)
    }
    
    let activityViewModel = TitleDisclosureCellViewModel(title: R.string.localizable.activity())
    
    let gamesViewModel = TitleDisclosureCellViewModel(title: R.string.localizable.games())
    
    let friendsViewModel = TitleDisclosureCellViewModel(title: R.string.localizable.friends())

    // MARK: - Computed Properties
    
    private var realName: String? {
        return player?.realName
    }
    
    var userName: String? {
        return player?.personaName
    }
    
    private var createdDate: String? {
        guard let player = player else { return nil }
        guard let timeCreated = player.timeCreated else { return nil }
        
        return DateFormatter.year.string(from: timeCreated)
    }
    
    private var countryCode: String? {
        return player?.locCountryCode
    }

    // MARK: - Services
    
    private let steamUserService = SteamUserService()
    
    private let steamPlayerService = SteamPlayerService()
    
    private let authService = AuthService()
    
    private let notificationCenter = NotificationCenter.default

    // MARK: - Init

    init(steamId: String? = nil) {
        isUserProfile = steamId == nil
        
        super.init()
        
        self.steamId = isUserProfile ? authService.steamId : steamId
        
        if isUserProfile {
            observeAuthState()
        }
    }

}

// MARK: - Public

extension ProfileViewModel {
    
    func loadUserProfile() {
        guard let steamId = steamId else { return }
        
        player = nil
        badgesResponse = nil
        groupsCount = nil
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        steamUserService.getPlayerSummaries(steamId: steamId) { [weak self] result in
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

extension ProfileViewModel {

    func logout() {
        authService.logout()
    }

}

// MARK: - Private

private extension ProfileViewModel {

    func observeAuthState() {
        notificationCenter.addObserver(forName: .didChangeAuthState,
                                       object: nil,
                                       queue: .main) { [weak self] _ in
            guard let self = self else { return }
            if self.authService.isLoggenIn {
                self.didLogin?()
                self.steamId = self.authService.steamId
                self.loadUserProfile()
            } else {
                self.didLogout?()
            }
        }
    }

}
