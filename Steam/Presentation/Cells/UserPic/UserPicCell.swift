import TableKit
import Utils

class UserPicCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let userPicImageSize: CGFloat = 100
        
    }
    
    // MARK: - Views
    
    private let userPicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.userPicImageSize / 2
        return imageView
    }()
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: contentView)
    }

    // MARK: - Views
    
    override func addViews() {
        contentView.addSubview(userPicImageView)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureImageViewConstraints()
    }
    
}

// MARK: - Themeable

extension UserPicCell: Themeable {
    
    func apply(theme: Theme) {
        userPicImageView.backgroundColor = theme.accentColor
    }
    
}

// MARK: - ConfigureCell

extension UserPicCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 116
    
    func configure(with viewModel: UserPicCellViewModel) {
        userPicImageView.loadImage(url: viewModel.userPicUrl)
    }
    
}

// MARK: - Constraints

private extension UserPicCell {
    
    func configureImageViewConstraints() {
        userPicImageView.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(CGFloat.verticalMargin)
            make.bottom.equalToSuperview().inset(CGFloat.verticalMargin).priority(.low)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.size.equalTo(Constants.userPicImageSize)
        }
    }
    
}
