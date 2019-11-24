class StatsViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    let appId: Int

    let schemaStats: [SchemaStat]
    
    let stats: [Stat]

    // MARK: - Cells View Models

    var statsViewModels: [StatCellViewModel] {
        return schemaStats.map { schemaStat in
            let value = stats.first { $0.name == schemaStat.name }?.value
            return StatCellViewModel(title: schemaStat.displayName.isEmpty ? schemaStat.name : schemaStat.displayName,
                                     value: Int(value ?? 0))
        }
    }

    // MARK: - Init

    init(appId: Int,
         schemaStats: [SchemaStat],
         stats: [Stat]) {
        
        self.appId = appId
        self.schemaStats = schemaStats
        self.stats = stats
    }

}
