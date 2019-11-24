import TableKit
import Utils

class GameHeaderCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let priceContainerHorizontalPaddding: CGFloat = 30
        
        static let priceContainerVerticalPaddding: CGFloat = 20
        
        static let picImageViewTrailing: CGFloat = 60
        
        static let cornerRadius: CGFloat = 50
        
        static let platformsStackViewTrailing: CGFloat = 20
        
        static let platformsStackViewSize: CGFloat = 16
        
        static let platformsStackViewSpacing: CGFloat = 12
        
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
    
    private let priceContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xF6C121)
        view.clipsToBounds = true
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let platformsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Constants.platformsStackViewSpacing
        return view
    }()
    
    // MARK: - Views
    
    override func addViews() {
        priceContainerView.addSubview(priceLabel)
        picImageView.addSubview(priceContainerView)
        
        contentView.addSubviews(
            picImageView,
            platformsStackView
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configurePriceLabelConstraints()
        configurePriceContainerViewConstraints()
        configurePicImageViewConstraints()
        configurePlatformsStackViewConstraints()
    }
    
}

// MARK: - ConfigureCell

extension GameHeaderCell: ConfigurableCell {
    
    static let defaultHeight: CGFloat? = 220
    
    func configure(with viewModel: GameHeaderCellViewModel) {
        picImageView.loadImage(url: viewModel.picUrl)
        priceLabel.text = viewModel.price
        
        platformsStackView.clear()
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
    
    func configurePriceLabelConstraints() {
        priceLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(Constants.priceContainerVerticalPaddding)
            make.leading.equalToSuperview().inset(Constants.priceContainerHorizontalPaddding)
            make.bottom.equalToSuperview().inset(Constants.cornerRadius + Constants.priceContainerVerticalPaddding)
            make.trailing.equalToSuperview().inset(Constants.cornerRadius + Constants.priceContainerHorizontalPaddding)
        }
    }
    
    func configurePriceContainerViewConstraints() {
        priceContainerView.snp.remakeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(-Constants.cornerRadius)
        }
    }
    
    func configurePicImageViewConstraints() {
        picImageView.snp.remakeConstraints { make in
            make.leading.equalToSuperview().inset(-Constants.cornerRadius)
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(Constants.picImageViewTrailing)
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
