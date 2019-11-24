import TableKit
import Utils

class CountryCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let flagImageWidth: CGFloat = 20
        
        static let countryNameLeading: CGFloat = -10
        
    }
    
    // MARK: - Views
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.addShadow(radius: 2, opacity: 0.2)
        return imageView
    }()
    
    private let countryNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()

    // MARK: - Views
    
    override func addViews() {
        contentView.addSubviews(
            flagImageView,
            countryNameLabel
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureFlagImageViewConstraints()
        configureCountryNameLabelConstraints()
    }
    
}

// MARK: - ConfigureCell

extension CountryCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 30
    
    func configure(with viewModel: CountryCellViewModel) {
        flagImageView.image = viewModel.flagImage
        countryNameLabel.text = viewModel.title
    }
    
}

// MARK: - Constraints

private extension CountryCell {
    
    func configureFlagImageViewConstraints() {
        flagImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        flagImageView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.top.bottom.equalToSuperview().inset(CGFloat.verticalMargin)
        }
    }
    
    func configureCountryNameLabelConstraints() {
        countryNameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(flagImageView.snp.trailing).inset(Constants.countryNameLeading)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin).priority(.low)
        }
    }
    
}
