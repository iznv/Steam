import ApiKit
import SteamKit

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
    
    private var details: AppDetails?
    
    private var playersOnline: Int?
    
    // MARK: - Computed Properties
    
    private var price: String? {
        guard let details = details else { return nil }
        
        if let priceOverview = details.priceOverview {
            return priceOverview.finalFormatted
        } else {
            return R.string.localizable.free()
        }
    }
    
    // MARK: - Events
    
    var didGetDetails: (() -> Void)?

    // MARK: - Cells View Models
    
    var headerViewModel: GameHeaderCellViewModel? {
        guard let details = details else { return nil }
        return GameHeaderCellViewModel(picUrl: details.background, platforms: details.platforms)
    }
    
    var titleViewModel: TextCellViewModel? {
        details.map { TextCellViewModel(text: $0.name, font: .medium26()) }
    }
    
    var genresViewModel: TextCellViewModel? {
        details?.genres.map {
            TextCellViewModel(text: $0.map { $0.description }.joined(separator: Constants.genresSeparator),
                              font: .medium12(),
                              color: { $0.primaryTextColor.withAlphaComponent(0.5) })
        }
    }
    
    var descriptionViewModel: TextCellViewModel? {
        details.map { TextCellViewModel(text: $0.shortDescription.htmlDecoded, font: .medium14()) }
    }
    
    var priceMetacriticViewModel: TitleValueCollectionCellViewModel? {
        var items = [TitleValueItem]()
        
        if let price = price {
            items.append(TitleValueItem(title: R.string.localizable.gamePrice(), value: price))
        }
        
        if let score = details?.metacritic?.score {
            items.append(TitleValueItem(title: R.string.localizable.gameMetacritic(), value: String(score)))
        }
        
        return items.isEmpty ? nil : TitleValueCollectionCellViewModel(items: items)
    }
    
    var playersViewModel: TitleValueCollectionCellViewModel? {
        var items = [TitleValueItem]()
        
        if let playersOnline = playersOnline {
            items.append(TitleValueItem(title: R.string.localizable.gamePlayersOnline(),
                                        value: NumberFormatter.common.string(from: NSNumber(value: playersOnline)) ?? .empty))
        }
        
        return items.isEmpty ? nil : TitleValueCollectionCellViewModel(items: items)
    }
    
    var releaseViewModel: TitleValueCollectionCellViewModel? {
        var items = [TitleValueItem]()
        
        if let date = details?.releaseDate.date {
            items.append(TitleValueItem(title: R.string.localizable.gameReleaseDate(), value: date))
        }
        
        return items.isEmpty ? nil : TitleValueCollectionCellViewModel(items: items)
    }
    
    var publisherViewModel: TitleValueCollectionCellViewModel? {
        var items = [TitleValueItem]()
        
        if let publisher = details?.publishers.first {
            items.append(TitleValueItem(title: R.string.localizable.gamePublisher(), value: publisher))
        }
        
        return items.isEmpty ? nil : TitleValueCollectionCellViewModel(items: items)
    }
    
    // MARK: - Services
    
    private let steamStoreService = SteamStoreService()
    
    private let steamUserStatsService = SteamUserStatsService()
    
    // MARK: - Init

    init(appId: Int) {
        self.appId = appId
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
