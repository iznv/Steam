import TableKit
import Utils

class StatCompareCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
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
        return label
    }()
    
    private let value2Label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
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

// MARK: - ConfigureCell

extension StatCompareCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 70
    
    func configure(with viewModel: StatCompareCellViewModel) {
        titleLabel.text = viewModel.title
        value1Label.text = viewModel.value1
        value2Label.text = viewModel.value2
    }
    
}

// MARK: - Constraints

private extension StatCompareCell {
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(CGFloat.verticalMargin)
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureValuesStackViewConstraints() {
        valuesStackView.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.bottom.equalToSuperview().inset(CGFloat.verticalMargin)
        }
    }
    
}
