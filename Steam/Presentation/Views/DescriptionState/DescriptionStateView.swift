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
        return label
    }()
    
    // MARK: - Properties
    
    var stateDescription: String? {
        didSet {
            descriptionLabel.text = stateDescription
        }
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

// MARK: - Constraints

private extension DescriptionStateView {
    
    func configureDescriptionLabelConstraints() {
        descriptionLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.centerY.equalToSuperview()
        }
    }

}
