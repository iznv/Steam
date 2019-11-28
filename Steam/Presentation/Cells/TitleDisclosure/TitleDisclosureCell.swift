import TableKit
import Utils

class TitleDisclosureCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
    }
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium16()
        return label
    }()
    
    private let disclosureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.disclosure()
        return imageView
    }()

    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()

        enableTheme(for: contentView)
    }
    
    // MARK: - Views
    
    override func addViews() {
        contentView.addSubviews(
            titleLabel,
            disclosureImageView
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureTitleLabelConstraints()
        configureDisclosureImageViewConstraints()
    }
    
}

// MARK: - Themeable

extension TitleDisclosureCell: Themeable {
    
    func apply(theme: Theme) {
        titleLabel.textColor = theme.primaryTextColor
        disclosureImageView.tintColor = theme.primaryTextColor.withAlphaComponent(0.3)
    }
    
}

// MARK: - ConfigureCell

extension TitleDisclosureCell: ConfigurableCell {
    
    static let defaultHeight: CGFloat? = 54
    
    func configure(with viewModel: TitleDisclosureCellViewModel) {
        titleLabel.text = viewModel.title
    }
    
}

// MARK: - Constraints

private extension TitleDisclosureCell {
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureDisclosureImageViewConstraints() {
        disclosureImageView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.size.equalTo(CGFloat.disclosureSize)
        }
    }
    
}
