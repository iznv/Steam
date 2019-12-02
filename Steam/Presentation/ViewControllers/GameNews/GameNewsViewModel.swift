import ApiKit
import SteamKit
import WEBBCode

class GameNewsViewModel: BaseControllerViewModel {
    
    // MARK: - Properties

    private let appId: Int
        
    // MARK: - Events
    
    var didGetNews: (() -> Void)?
    
    var didGetNoNews: (() -> Void)?

    // MARK: - Cells View Models
    
    var newsViewModels: [NewsCellViewModel]?

    // MARK: - Services
    
    private let newsService = NewsService()

    // MARK: - Init

    init(appId: Int) {
        self.appId = appId
    }

}

// MARK: - Public

extension GameNewsViewModel {
    
    func loadNews() {
        newsViewModels = nil
        
        newsService.recentNews(appId: appId) { [weak self] result in
            switch result {
            case let .success(news):
                print(news.count)
                if news.isEmpty {
                    self?.didGetNoNews?()
                } else {
                    self?.newsViewModels = news.map { NewsCellViewModel(article: $0) }
                    self?.didGetNews?()
                }
            case let .failure(error):
                self?.handle(error)
            }
        }
    }
    
}
