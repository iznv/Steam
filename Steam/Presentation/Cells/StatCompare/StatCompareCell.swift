import TableKit
import Utils

class StatCompareCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let valuesStackViewTop: CGFloat = -10
        
        static let verticalMargin: CGFloat = 30
        
        static let winAlpha: CGFloat = 1
        
        static let defeatAlpha: CGFloat = 0.3
    }
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .bold16()
        return label
    }()
    
    private let valuesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let value1Label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .medium14()
        return label
    }()
    
    private let value2Label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .medium14()
        return label
    }()
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: contentView)
    }
    
    // MARK: - Views
    
    override func addViews() {
        [value1Label, value2Label].forEach { valuesStackView.addArrangedSubview($0) }
        
        contentView.addSubviews(
            titleLabel,
            valuesStackView
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureTitleLabelConstraints()
        configureValuesStackViewConstraints()
    }
    
}

// MARK: - Themeable

extension StatCompareCell: Themeable {
    
    func apply(theme: Theme) {
        titleLabel.textColor = theme.primaryTextColor
        value1Label.textColor = theme.primaryTextColor
        value2Label.textColor = theme.primaryTextColor
    }
    
}

// MARK: - ConfigureCell

extension StatCompareCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 70
    
    func configure(with viewModel: StatCompareCellViewModel) {
        titleLabel.text = viewModel.title
        value1Label.text = viewModel.value1
        value2Label.text = viewModel.value2
        
        switch viewModel.whoWin {
        case .first:
            value1Label.alpha = Constants.winAlpha
            value2Label.alpha = Constants.defeatAlpha
        case .second:
            value1Label.alpha = Constants.defeatAlpha
            value2Label.alpha = Constants.winAlpha
        case .draw:
            value1Label.alpha = Constants.defeatAlpha
            value2Label.alpha = Constants.defeatAlpha
        case .both:
            value1Label.alpha = Constants.winAlpha
            value2Label.alpha = Constants.winAlpha
        }
    }
    
}

// MARK: - Constraints

private extension StatCompareCell {
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(Constants.verticalMargin)
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureValuesStackViewConstraints() {
        valuesStackView.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(Constants.valuesStackViewTop)
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.bottom.equalToSuperview().inset(Constants.verticalMargin).priority(.low)
        }
    }
    
}
