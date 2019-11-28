import FlagKit

struct CountryCellViewModel {

    // MARK: - Properties

    let flagImage: UIImage?
    
    let title: String?
    
    // MARK: - Init
    
    init(countryCode: String) {
        flagImage = Flag(countryCode: countryCode)?.image(style: .roundedRect)
        title = Locale.enUS.localizedString(forRegionCode: countryCode)
    }
    
}
