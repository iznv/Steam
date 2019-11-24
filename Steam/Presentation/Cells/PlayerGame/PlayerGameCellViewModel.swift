import Foundation

struct PlayerGameCellViewModel {
    
    // MARK: - Properties

    let picUrl: URL?
    
    let title: String
    
    let lastTwoWeekPlayed: String?
    
    let onRecordPlayed: String?
    
    // MARK: - Services
    
    private let formattingService = FormattingService()
    
    // MARK: - Init
    
    init(game: PlayerGame) {
        self.picUrl = URL(string: game.iconUrl)
        self.title = game.title
        self.lastTwoWeekPlayed = formattingService.timePlayed(timeInMinutes: game.lastTwoWeekMinutesPlayed)
        self.onRecordPlayed = formattingService.timePlayed(timeInMinutes: game.onRecordMinutesPlayed)
    }
    
}
