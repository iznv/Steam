import Foundation

struct StatCellViewModel {
    
    // MARK: - Properties
    
    let name: String

    let title: String
    
    let value: String?
    
    // MARK: - Init
    
    init(name: String,
         title: String,
         value: Int) {
        
        self.name = name
        self.title = title
        self.value = NumberFormatter.common.string(from: NSNumber(value: value))
    }
    
}
