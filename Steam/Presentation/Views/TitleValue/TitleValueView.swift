import Utils

class TitleValueView: BaseView {

    // MARK: - Constants

    private struct Constants {
    

    
    }
    
    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium12()
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .medium26()
        return label
    }()
    
    // MARK: Properties
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var value: String? {
        didSet {
            valueLabel.text = value
        }
    }
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: self)
    }
    
    // MARK: - Subviews
    
    override func addViews() {
        addSubviews(
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

// MARK: - Themeable

extension TitleValueView: Themeable {
    
    func apply(theme: Theme) {
        titleLabel.textColor = theme.primaryTextColor.withAlphaComponent(0.5)
        valueLabel.textColor = theme.primaryTextColor
    }
    
}

// MARK: - Constraints

private extension TitleValueView {
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.leading.top.equalToSuperview()
        }
    }
    
    func configureValueLabelConstraints() {
        valueLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview().priority(.low)
            make.leading.trailing.equalToSuperview()
        }
    }

}
