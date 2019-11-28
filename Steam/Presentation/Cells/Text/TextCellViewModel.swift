import UIKit

struct TextCellViewModel {
    
    // MARK: - Properties

    let text: String?
    
    let font: UIFont?
    
    let color: ((Theme) -> UIColor)?
    
    // MARK: - Init
    
    init(text: String?,
         font: UIFont? = .medium12(),
         color: ((Theme) -> UIColor)? = nil) {
        
        self.text = text
        self.font = font
        self.color = color
    }
    
}
