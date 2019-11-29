import Utils

class CustomStateView: BaseView {

    // MARK: - Constants

    private struct Constants {
    
        static let descriptionLabelTop: CGFloat = -20
        
        static let buttonInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        static let buttonHeight: CGFloat = 38
    
    }
    
    // MARK: - Views
    
    private let containerView: UIView = {
        let view = UIView()
        
        return view
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .medium16()
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = Constants.buttonHeight / 2
        button.contentEdgeInsets = Constants.buttonInsets
        button.titleLabel?.font = .bold17()
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    var stateDescription: String? {
        didSet {
            descriptionLabel.text = stateDescription
        }
    }
    
    var buttonTitle: String? {
        didSet {
            button.setTitle(buttonTitle, for: .normal)
        }
    }
    
    var didTapButton: (() -> Void)?
    
    // MARK: - Initialization
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: self)
        
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }

    // MARK: - Subviews
    
    override func addViews() {
        containerView.addSubviews(
            descriptionLabel,
            button
        )
        
        addSubview(containerView)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureDescriptionLabelConstraints()
        configureButtonConstraints()
        configureContainerViewConstraints()
    }
    
    // MARK: - Appearance
    
    override func configureAppearance() {
        backgroundColor = .white
    }
    
}

// MARK: - Themeable

extension CustomStateView: Themeable {
    
    func apply(theme: Theme) {
        backgroundColor = theme.primaryBackgroundColor
        descriptionLabel.textColor = theme.primaryTextColor
        button.backgroundColor = theme.accentColor
    }
    
}

// MARK: - Constraints

private extension CustomStateView {
    
    func configureDescriptionLabelConstraints() {
        descriptionLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureButtonConstraints() {
        button.snp.remakeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).inset(Constants.descriptionLabelTop)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Constants.buttonHeight)
        }
    }
    
    func configureContainerViewConstraints() {
        containerView.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}

// MARK: - Private

private extension CustomStateView {
    
    @objc func tap() {
        didTapButton?()
    }
    
}
