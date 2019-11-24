import TableKit
import Utils

class AchievementCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let picCornerRadius: CGFloat = 4
        
        static let gamePicImageViewSize: CGFloat = 32
        
        static let titleLabelLeading: CGFloat = -10
        
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
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
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
            make.top.equalToSuperview().inset(CGFloat.verticalMargin)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.size.equalTo(Constants.gamePicImageViewSize)
        }
    }
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(picImageView.snp.top)
            make.leading.equalTo(picImageView.snp.trailing).inset(Constants.titleLabelLeading)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureDescriptionLabelConstraints() {
        descriptionLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.bottom.equalToSuperview().inset(CGFloat.verticalMargin)
        }
    }
    
}
