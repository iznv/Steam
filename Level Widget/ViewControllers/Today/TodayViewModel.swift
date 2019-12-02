import ApiKit
import SteamKit
import NotificationCenter

class TodayViewModel {
    
    // MARK: - Events
    
    var didLoadLevel: ((Level) -> Void)?
    
    var onNoSteamId: (() -> Void)?

    // MARK: - Services
    
    private let authService = AuthService()
        
    private let steamPlayerService = SteamPlayerService()

}

// MARK: - Public

extension TodayViewModel {

    func loadLevel(completionHandler: ((NCUpdateResult) -> Void)? = nil) {
        guard let steamId = authService.steamId else {
            onNoSteamId?()
            return
        }
        
        steamPlayerService.getBadges(steamId: steamId) { [weak self] result in
            switch result {
            case let .success(badges):
                self?.showLevel(badges: badges, completionHandler: completionHandler)
            case .failure:
                completionHandler?(NCUpdateResult.noData)
            }
        }
    }

}

// MARK: - Private

private extension TodayViewModel {
    
    func showLevel(badges: BadgesResponse,
                   completionHandler: ((NCUpdateResult) -> Void)? = nil) {
        
        if let level = level(for: badges) {
            didLoadLevel?(level)
            completionHandler?(NCUpdateResult.newData)
        } else {
            completionHandler?(NCUpdateResult.noData)
        }
    }
    
    func level(for response: BadgesResponse) -> Level? {
        guard let level = response.playerLevel,
              let xpTotal = response.playerXP,
              let xpLeft = response.playerXPNeededToLevelUp,
              let xpCurrentLevel = response.playerXPNeededCurrentLevel else {
            return nil
        }
        
        let title = String(format: "ProfileLevelValue".localized, String(level))
        
        let xpNextLevel = CGFloat(xpTotal + xpLeft)
        let xpFromCurrentLevelToNext = xpNextLevel - CGFloat(xpCurrentLevel)
        
        let progress = 1 - CGFloat(xpLeft) / xpFromCurrentLevelToNext
        let progressString = String(format: "ProfileLevelXPProgress".localized,
                                    String(xpTotal),
                                    String(Int(xpNextLevel)))
        
        return Level(title: title,
                     progress: progress,
                     progressString: progressString)
    }

}
