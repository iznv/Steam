import Utils

class DescriptionStateView: BaseView {

    // MARK: - Constants

    private struct Constants {
    

    
    }
    
    // MARK: - Views

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .medium16()
        return label
    }()
    
    // MARK: - Properties
    
    var stateDescription: String? {
        didSet {
            descriptionLabel.text = stateDescription
        }
    }
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: self)
    }
    
    // MARK: - Subviews
    
    override func addViews() {
        addSubview(descriptionLabel)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureDescriptionLabelConstraints()
    }
    
    // MARK: - Appearance
    
    override func configureAppearance() {
        backgroundColor = .white
    }
    
}

// MARK: - Themeable

extension DescriptionStateView: Themeable {
    
    func apply(theme: Theme) {
        backgroundColor = theme.primaryBackgroundColor
        descriptionLabel.textColor = theme.primaryTextColor
    }
    
}

// MARK: - Constraints

private extension DescriptionStateView {
    
    func configureDescriptionLabelConstraints() {
        descriptionLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.centerY.equalToSuperview()
        }
    }

}
