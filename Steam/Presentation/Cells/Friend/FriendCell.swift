import TableKit
import Utils

class FriendCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let titleLabelTop: CGFloat = -3
        
        static let userPicImageViewSize: CGFloat = 60
        
        static let userNameLabelLeading: CGFloat = -16
        
        static let picCornerRadius: CGFloat = 4
        
    }
    
    // MARK: - Views
    
    private let userPicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.picCornerRadius
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .bold16()
        return label
    }()
    
    private let realNameLabel: UILabel = {
        let label = UILabel()
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
        contentView.addSubviews(
            userPicImageView,
            realNameLabel,
            userNameLabel
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureUserPicImageViewConstraints()
        configureRealNameLabelConstraints()
        configureUserNameLabelConstraints()
    }
    
}

// MARK: - Themeable

extension FriendCell: Themeable {
    
    func apply(theme: Theme) {
        userPicImageView.backgroundColor = theme.accentColor
        userNameLabel.textColor = theme.primaryTextColor
        realNameLabel.textColor = theme.primaryTextColor.withAlphaComponent(0.5)
    }
    
}

// MARK: - ConfigureCell

extension FriendCell: ConfigurableCell {
    
    static let defaultHeight: CGFloat? = 100
    
    func configure(with viewModel: FriendCellViewModel) {
        userPicImageView.loadImage(url: viewModel.userPicUrl)
        realNameLabel.text = viewModel.realName
        userNameLabel.text = viewModel.userName
    }
    
}

// MARK: - Constraints

private extension FriendCell {
    
    func configureUserPicImageViewConstraints() {
        userPicImageView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.size.equalTo(Constants.userPicImageViewSize)
        }
    }
    
    func configureRealNameLabelConstraints() {
        realNameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(userNameLabel.snp.leading)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.top.equalTo(userNameLabel.snp.bottom)
        }
    }
    
    func configureUserNameLabelConstraints() {
        userNameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(userPicImageView.snp.trailing).inset(Constants.userNameLabelLeading)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.top.equalTo(userPicImageView.snp.top).inset(Constants.titleLabelTop)
        }
    }
    
}
