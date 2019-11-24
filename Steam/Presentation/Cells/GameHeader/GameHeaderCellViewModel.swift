import UIKit

struct GameHeaderCellViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Properties

    let picUrl: URL?
    
    let price: String?
    
    let platforms: [UIImage]
    
    // MARK: - Init
    
    init(picUrl: String,
         price: String?,
         platforms: Platforms) {
        
        self.picUrl = URL(string: picUrl)
        self.price = price
        
        var platformsImages = [UIImage?]()
        
        if platforms.windows {
            platformsImages.append(R.image.platfromLogoWindows())
        }
        
        if platforms.mac {
            platformsImages.append(R.image.platfromLogoMac())
        }
        
        if platforms.linux {
            platformsImages.append(R.image.platfromLogoLinux())
        }
        
        self.platforms = platformsImages.compactMap { $0 }
    }
    
}
