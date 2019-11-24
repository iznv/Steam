import Foundation

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
        self.lastTwoWeekPlayed = formattingService.timePlayed(timeInMinutes: game.lastTwoWeekMinutesPlayed)
        self.onRecordPlayed = formattingService.timePlayed(timeInMinutes: game.onRecordMinutesPlayed)
    }
    
}
