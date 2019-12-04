import TableKit
import Utils

class NewsCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let verticalMargin: CGFloat = 20
        
        static let dateLabelTop: CGFloat = -10
        
    }
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .medium20()
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .medium12()
        return label
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
            dateLabel
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureTitleLabelConstraints()
        configureDateLabelConstraints()
    }
    
}

// MARK: - Themeable

extension NewsCell: Themeable {
    
    func apply(theme: Theme) {
        titleLabel.textColor = theme.primaryTextColor
        dateLabel.textColor = theme.primaryTextColor.withAlphaComponent(0.5)
    }
    
}

// MARK: - ConfigureCell

extension NewsCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 150
    
    func configure(with viewModel: NewsCellViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
    }
    
}

// MARK: - Constraints

private extension NewsCell {
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(Constants.verticalMargin)
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureDateLabelConstraints() {
        dateLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(Constants.dateLabelTop)
            make.bottom.equalToSuperview().inset(Constants.verticalMargin).priority(.low)
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
}
