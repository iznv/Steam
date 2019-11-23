import Utils

class CustomStateView: BaseView {

    // MARK: - Constants

    private struct Constants {
    
        static let descriptionLabelTop: CGFloat = -20
    
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
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        
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
