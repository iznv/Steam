import TableKit
import Utils

class CustomStatHeaderCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let titleLabelLeading: CGFloat = -14
        
        static let iconImageViewSize: CGFloat = 34
        
    }
    
    // MARK: - Views
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium20()
        return label
    }()
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: self)
    }
    
    // MARK: - Views
    
    override func addViews() {
        contentView.addSubviews(
            iconImageView,
            titleLabel
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureIconImageViewConstraints()
        configureTitleLabelConstraints()
    }
    
}

// MARK: - Themeable

extension CustomStatHeaderCell: Themeable {
    
    func apply(theme: Theme) {
        titleLabel.textColor = theme.accentColor
        iconImageView.tintColor = theme.accentColor
    }
    
}

// MARK: - ConfigureCell

extension CustomStatHeaderCell: ConfigurableCell {
    
    static let defaultHeight: CGFloat? = 60
    
    func configure(with viewModel: CustomStatHeaderCellViewModel) {
        iconImageView.image = viewModel.icon
        titleLabel.text = viewModel.title
    }
    
}

// MARK: - Constraints

private extension CustomStatHeaderCell {
    
    func configureIconImageViewConstraints() {
        iconImageView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.size.equalTo(Constants.iconImageViewSize)
        }
    }
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).inset(Constants.titleLabelLeading)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
}
