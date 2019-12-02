import TableKit
import Utils

class GameHeaderCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let picImageViewTrailing: CGFloat = 60
        
        static let cornerRadius: CGFloat = 24
        
        static let platformsStackViewTrailing: CGFloat = 20
        
        static let platformsStackViewSize: CGFloat = 16
        
        static let platformsStackViewSpacing: CGFloat = 18
        
    }
    
    // MARK: - Views

    private let picImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let platformsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.tintColor = .white
        view.spacing = Constants.platformsStackViewSpacing
        return view
    }()
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: contentView)
    }
    
    // MARK: - Views
    
    override func addViews() {
        picImageView.addSubview(platformsStackView)
        contentView.addSubviews(
            picImageView
        )
    }
    
    // MARK: - Properties
    
    var viewModel: GameHeaderCellViewModel?
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configurePicImageViewConstraints()
        configurePlatformsStackViewConstraints()
    }
    
}

// MARK: - Themeable

extension GameHeaderCell: Themeable {
    
    func apply(theme: Theme) {
        picImageView.backgroundColor = theme.accentColor
    }
    
}

// MARK: - ConfigureCell

extension GameHeaderCell: ConfigurableCell {
    
    static let defaultHeight: CGFloat? = 180
    
    func configure(with viewModel: GameHeaderCellViewModel) {
        guard self.viewModel == nil else { return }
        self.viewModel = viewModel
        
        picImageView.loadImage(url: viewModel.picUrl)

        viewModel.platforms.forEach { platform in
            let imageView = UIImageView(image: platform)
            imageView.snp.remakeConstraints { make in
                make.width.height.equalTo(Constants.platformsStackViewSize)
            }
            platformsStackView.addArrangedSubview(imageView)
        }
    }
    
}

// MARK: - Constraints

private extension GameHeaderCell {

    func configurePicImageViewConstraints() {
        picImageView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configurePlatformsStackViewConstraints() {
        platformsStackView.snp.remakeConstraints { make in
            make.centerY.equalTo(picImageView.snp.centerY)
            make.trailing.equalToSuperview().inset(Constants.platformsStackViewTrailing)
            make.width.equalTo(Constants.platformsStackViewSize)
        }
    }
    
}
