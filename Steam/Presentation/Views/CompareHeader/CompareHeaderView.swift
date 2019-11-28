import Utils

class CompareHeaderView: BaseView {

    // MARK: - Constants

    private struct Constants {
    

    
    }
    
    // MARK: - Views

    private let valuesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let value1Label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .bold17()
        return label
    }()
    
    private let value2Label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .bold17()
        return label
    }()

    // MARK: - Properties

    var value1: String? {
        didSet {
            value1Label.text = value1
        }
    }
    
    var value2: String? {
        didSet {
            value2Label.text = value2
        }
    }
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: self)
    }
    
    // MARK: - Subviews
    
    override func addViews() {
        [value1Label, value2Label].forEach { valuesStackView.addArrangedSubview($0) }
        addSubviews(valuesStackView)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureValuesStackViewConstraints()
    }
    
}

// MARK: - Themeable

extension CompareHeaderView: Themeable {
    
    func apply(theme: Theme) {
        value1Label.textColor = theme.primaryTextColor.withAlphaComponent(0.5)
        value2Label.textColor = theme.primaryTextColor.withAlphaComponent(0.5)
        backgroundColor = theme.primaryBackgroundColor
    }
    
}

// MARK: - Constraints

private extension CompareHeaderView {
    
    func configureValuesStackViewConstraints() {
        valuesStackView.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(CGFloat.verticalMargin)
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.bottom.equalToSuperview().inset(CGFloat.verticalMargin)
        }
    }

}
