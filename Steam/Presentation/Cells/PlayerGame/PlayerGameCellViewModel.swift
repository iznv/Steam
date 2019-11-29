import SteamKit

struct PlayerGameCellViewModel {
    
    // MARK: - Properties
    
    let appId: Int

    let picUrl: URL?
    
    let title: String
    
    let lastTwoWeekPlayed: String?
    
    let onRecordPlayed: String?
    
    // MARK: - Services
    
    private let formattingService = FormattingService()
    
    // MARK: - Init
    
    init(game: PlayerGame) {
        self.appId = game.appId
        self.picUrl = URL(string: game.iconUrl)
        self.title = game.title
        
        if let lastTwoWeekMinutesPlayed = game.lastTwoWeekMinutesPlayed {
            self.lastTwoWeekPlayed = formattingService.timePlayed(timeInMinutes: lastTwoWeekMinutesPlayed, timePlayed: .pastTwoWeeks)
        } else {
            self.lastTwoWeekPlayed = nil
        }

        self.onRecordPlayed = formattingService.timePlayed(timeInMinutes: game.onRecordMinutesPlayed,
                                                           timePlayed: .onRecord)
    }
    
}
