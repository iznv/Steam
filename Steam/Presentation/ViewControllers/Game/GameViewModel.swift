import Foundation

class GameViewModel: BaseControllerViewModel {
    
    // MARK: - Errors
    
    enum Error: Swift.Error {
        
        case noDetails
        
    }
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let genresSeparator = "   "
        
    }

    // MARK: - Properties

    let appId: Int
    
    let steamId: String
    
    private var details: AppDetails?
    
    private var playersOnline: Int?
    
    // MARK: - Events
    
    var didGetDetails: (() -> Void)?

    // MARK: - Cells View Models
    
    var headerViewModel: GameHeaderCellViewModel? {
        guard let details = details else { return nil }
        
        let price: String?
        if let priceOverview = details.priceOverview {
            price = priceOverview.finalFormatted
        } else {
            price = R.string.localizable.free()
        }
        
        return GameHeaderCellViewModel(picUrl: details.background, price: price, platforms: details.platforms)
    }
    
    var titleViewModel: TextCellViewModel? {
        details.map { TextCellViewModel(text: $0.name) }
    }
    
    var genresViewModel: TextCellViewModel? {
        details?.genres.map { TextCellViewModel(text: $0.map { $0.description }.joined(separator: Constants.genresSeparator)) }
    }
    
    var descriptionViewModel: TextCellViewModel? {
        details.map { TextCellViewModel(text: $0.shortDescription.htmlDecoded) }
    }
    
    var metacriticAndPlayersViewModel: TitleValueCollectionCellViewModel? {
        var items = [TitleValueItem]()
        
        if let score = details?.metacritic?.score {
            items.append(TitleValueItem(title: R.string.localizable.gameMetacritic(), value: String(score)))
        }
        
        if let playersOnline = playersOnline, playersOnline > 0 {
            items.append(TitleValueItem(title: R.string.localizable.gamePlayersOnline(), value: String(playersOnline)))
        }
        
        return items.isEmpty ? nil : TitleValueCollectionCellViewModel(items: items)
    }
    
    var releaseAndPublisherViewModel: TitleValueCollectionCellViewModel? {
        var items = [TitleValueItem]()
        
        if let date = details?.releaseDate.date {
            items.append(TitleValueItem(title: R.string.localizable.gameReleaseDate(), value: date))
        }
        
        if let publisher = details?.publishers.first {
            items.append(TitleValueItem(title: R.string.localizable.gamePublisher(), value: publisher))
        }
        
        return items.isEmpty ? nil : TitleValueCollectionCellViewModel(items: items)
    }
    
    // MARK: - Services
    
    private let steamStoreService = SteamStoreService()
    
    private let steamUserStatsService = SteamUserStatsService()
    
    // MARK: - Init

    init(appId: Int,
         steamId: String) {
        
        self.appId = appId
        self.steamId = steamId
    }

}

// MARK: - Public

extension GameViewModel {
    
    func loadDetails() {
        details = nil
        playersOnline = nil

        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        steamStoreService.appDetails(appId: appId) { [weak self] result in
            switch result {
            case let .success(details):
                if let details = details {
                    self?.details = details
                } else {
                    self?.handle(Error.noDetails)
                }
            case let .failure(error):
                self?.handle(error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        steamUserStatsService.getNumberOfCurrentPlayers(appId: appId) { [weak self] result in
            switch result {
            case let .success(playersOnline):
                self?.playersOnline = playersOnline
            case let .failure(error):
                self?.handle(error)
            }
            
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard self?.details != nil else { return }
            self?.didGetDetails?()
        }
    }
    
}