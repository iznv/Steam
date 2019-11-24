struct StatCompareCellViewModel {
    
    // MARK: - Properties

    let title: String
    
    let value1: String
    
    let value2: String
    
    // MARK: - Init
    
    init(title: String,
         value1: Int,
         value2: Int) {
        
        self.title = title
        self.value1 = String(value1)
        self.value2 = String(value2)
    }
    
}
