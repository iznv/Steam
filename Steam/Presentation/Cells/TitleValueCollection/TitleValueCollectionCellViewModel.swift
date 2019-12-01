import UIKit

struct TitleValueCollectionCellViewModel {

    // MARK: - Properties

    let items: [TitleValueItem]

    let valueFont: UIFont?
    
    // MARK: - Init
    
    init(items: [TitleValueItem],
         valueFont: UIFont? = .medium26()) {
        
        self.items = items
        self.valueFont = valueFont
    }
    
}
