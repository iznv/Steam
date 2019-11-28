import Foundation

class StatHistoryViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    var hasNotZeroData: Bool = false
    
    private let appId: Int
    
    private let statName: String
    
    private var items: [StatItem]?
    
    // MARK: - Events
    
    var didGetHistory: (() -> Void)?
    
    var didGetNoHistory: (() -> Void)?

    // MARK: - Cells View Models
    
    var graphViewModel: GraphCellViewModel {
        return GraphCellViewModel(statItems: items ?? [])
    }

    var historyViewModels: [StatCellViewModel] {
        return items?.map { item in
            StatCellViewModel(name: .empty,
                              title: item.dateHistoryString,
                              value: Int(item.value))
        } ?? []
    }

    // MARK: - Services
    
    private let statHistoryService = StatHistoryService()

    // MARK: - Init

    init(appId: Int,
         statName: String) {
        
        self.appId = appId
        self.statName = statName
    }

}

// MARK: - Public

extension StatHistoryViewModel {

    func loadHistory() {
        statHistoryService.getStatItems(appId: appId, name: statName) { [weak self] items in
            guard let self = self else { return }
            
            if items.isEmpty {
                self.didGetNoHistory?()
            } else {
                self.items = items
                self.hasNotZeroData = items.reduce(false) { $0 || $1.value > 0 }
                self.didGetHistory?()
            }
        }
    }

}
