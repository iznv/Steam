import ApiKit

class StatsViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties

    let schemaStats: [SchemaStat]
    
    let stats: [Stat]
    
    private let steamId: String

    // MARK: - Cells View Models

    var statsViewModels: [StatCellViewModel] {
        return schemaStats.map { schemaStat in
            let value = stats.first { $0.name == schemaStat.name }?.value
            return StatCellViewModel(name: schemaStat.name,
                                     title: schemaStat.title,
                                     value: Int(value ?? 0))
        }
    }

    // MARK: - Init

    init(steamId: String,
         schemaStats: [SchemaStat],
         stats: [Stat]) {

        self.steamId = steamId
        self.schemaStats = schemaStats
        self.stats = stats
    }

}
