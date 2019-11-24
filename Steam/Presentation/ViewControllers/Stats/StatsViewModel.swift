class StatsViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties

    private let schemaStats: [SchemaStat]
    
    private let stats: [Stat]

    // MARK: - Cells View Models

    var statsViewModels: [StatCellViewModel] {
        return schemaStats.map { schemaStat in
            let value = stats.first { $0.name == schemaStat.name }?.value
            return StatCellViewModel(title: schemaStat.displayName.isEmpty ? schemaStat.name : schemaStat.displayName,
                                     value: value ?? 0)
        }
    }

    // MARK: - Init

    init(schemaStats: [SchemaStat],
         stats: [Stat]) {
        
        self.schemaStats = schemaStats
        self.stats = stats
    }

}
