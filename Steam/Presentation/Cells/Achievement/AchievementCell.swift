import TableKit
import Utils

class AchievementCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let titleLabelTop: CGFloat = -3
        
        static let picCornerRadius: CGFloat = 4
        
        static let gamePicImageViewSize: CGFloat = 32
        
        static let titleLabelLeading: CGFloat = -16
        
        static let verticalMargin: CGFloat = 20
        
    }
    
    // MARK: - Views
    
    private let picImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.picCornerRadius
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .bold16()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
            picImageView,
            titleLabel,
            descriptionLabel
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configurePicImageViewConstraints()
        configureTitleLabelConstraints()
        configureDescriptionLabelConstraints()
    }
    
}

// MARK: - Themeable

extension AchievementCell: Themeable {
    
    func apply(theme: Theme) {
        titleLabel.textColor = theme.primaryTextColor
        descriptionLabel.textColor = theme.primaryTextColor.withAlphaComponent(0.5)
        picImageView.backgroundColor = theme.accentColor
    }
    
}

// MARK: - ConfigureCell

extension AchievementCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 100
    
    func configure(with viewModel: AchievementCellViewModel) {
        picImageView.loadImage(url: viewModel.picUrl)
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
    
}

// MARK: - Constraints

private extension AchievementCell {
    
    func configurePicImageViewConstraints() {
        picImageView.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(Constants.verticalMargin)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.size.equalTo(Constants.gamePicImageViewSize)
        }
    }
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(picImageView.snp.top).inset(Constants.titleLabelTop)
            make.leading.equalTo(picImageView.snp.trailing).inset(Constants.titleLabelLeading)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureDescriptionLabelConstraints() {
        descriptionLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.bottom.equalToSuperview().inset(Constants.verticalMargin)
        }
    }
    
}
