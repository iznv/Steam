class CustomStatsViewModel {

    // MARK: - Properties

    let stats: [CustomStatistics]
    
    // MARK: - Cells View Models
    
    let allViewModel = TitleDisclosureCellViewModel(title: R.string.localizable.all())

    // MARK: - Init

    init(stats: [CustomStatistics]) {
        self.stats = stats
    }

}
