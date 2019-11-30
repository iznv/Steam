import TableKit
import Utils

class PrivateProfileCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let verticalMargin: CGFloat = 20
        
        static let containerCornerRadius: CGFloat = 26
        
    }
    
    // MARK: - Views
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.containerCornerRadius
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium16()
        label.text = R.string.localizable.profilePrivateProfile()
        return label
    }()
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: contentView)
    }
    
    // MARK: - Views
    
    override func addViews() {
        containerView.addSubview(titleLabel)
        contentView.addSubview(containerView)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureContainerViewConstraints()
        configureTitleLabelConstraints()
    }
    
}

// MARK: - Themeable

extension PrivateProfileCell: Themeable {
    
    func apply(theme: Theme) {
        containerView.backgroundColor = theme.secondaryBackgroundColor
        titleLabel.textColor = theme.primaryTextColor
    }
    
}

// MARK: - ConfigureCell

extension PrivateProfileCell: ConfigurableCell {
    
    static let defaultHeight: CGFloat? = 160
    
    func configure(with viewModel: Void) { }
    
}

// MARK: - Constraints

private extension PrivateProfileCell {
    
    func configureContainerViewConstraints() {
        containerView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.top.bottom.equalToSuperview().inset(Constants.verticalMargin)
        }
    }
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
