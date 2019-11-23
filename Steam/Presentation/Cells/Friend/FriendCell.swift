import TableKit
import Utils

class FriendCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let userPicImageViewSize: CGFloat = 60
        
        static let realNameLabelTrailing: CGFloat = -10
        
    }
    
    // MARK: - Views
    
    private let userPicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.userPicImageViewSize / 2
        return imageView
    }()
    
    private let realNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
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
            make.leading.equalTo(userPicImageView.snp.trailing).inset(Constants.realNameLabelTrailing)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.top.equalTo(userPicImageView.snp.top)
        }
    }
    
    func configureUserNameLabelConstraints() {
        userNameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(realNameLabel.snp.leading)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.top.equalTo(realNameLabel.snp.bottom)
        }
    }
    
}
