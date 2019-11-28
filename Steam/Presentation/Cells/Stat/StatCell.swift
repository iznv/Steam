import TableKit
import Utils

class StatCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let valueLabelLeading: CGFloat = -10
        
        static let titleLabelTrailing: CGFloat = 120
        
        static let verticalMargin: CGFloat = 20
        
    }
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .bold16()
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .bold16()
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
            valueLabel
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureTitleLabelConstraints()
        configureValueLabelConstraints()
    }
    
}

extension StatCell: Themeable {
    
    func apply(theme: Theme) {
        titleLabel.textColor = theme.primaryTextColor
        valueLabel.textColor = theme.primaryTextColor.withAlphaComponent(0.5)
    }
    
}

// MARK: - ConfigureCell

extension StatCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 80
    
    func configure(with viewModel: StatCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
    
}

// MARK: - Constraints

private extension StatCell {
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(Constants.verticalMargin)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.trailing.equalToSuperview().inset(Constants.titleLabelTrailing)
            make.bottom.equalToSuperview().inset(Constants.verticalMargin)
        }
    }
    
    func configureValueLabelConstraints() {
        valueLabel.snp.remakeConstraints { make in
            make.firstBaseline.equalTo(titleLabel.snp.firstBaseline)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
}
