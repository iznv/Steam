class StatsViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties
    
    let appId: Int

    let schemaStats: [SchemaStat]
    
    let stats: [Stat]
    
    private let steamId: String
    
    // MARK: - Computed Properties
    
    var canCompare: Bool {
        return authService.steamId != steamId
    }

    // MARK: - Cells View Models

    var statsViewModels: [StatCellViewModel] {
        return schemaStats.map { schemaStat in
            let value = stats.first { $0.name == schemaStat.name }?.value
            return StatCellViewModel(name: schemaStat.name,
                                     title: schemaStat.title,
                                     value: Int(value ?? 0))
        }
    }
    
    // MARK: - Services
    
    private let authService = AuthService()

    // MARK: - Init

    init(appId: Int,
         steamId: String,
         schemaStats: [SchemaStat],
         stats: [Stat]) {
        
        self.appId = appId
        self.steamId = steamId
        self.schemaStats = schemaStats
        self.stats = stats
    }

}
