import TableKit
import Utils

class PlayerGameCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let titleLabelTop: CGFloat = -3
        
        static let picCornerRadius: CGFloat = 4
        
        static let gamePicImageViewSize: CGFloat = 16
        
        static let titleLabelLeading: CGFloat = -16
        
        static let verticalMargin: CGFloat = 20
        
    }
    
    // MARK: - Views
    
    private let gamePicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
    
    private let lastTwoWeeksNameLabel: UILabel = {
        let label = UILabel()
        label.font = .medium14()
        return label
    }()
    
    private let onRecordLabel: UILabel = {
        let label = UILabel()
        label.font = .medium14()
        return label
    }()
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: self)
    }
    
    // MARK: - Views
    
    override func addViews() {
        contentView.addSubviews(
            gamePicImageView,
            titleLabel,
            lastTwoWeeksNameLabel,
            onRecordLabel
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureGamePicImageViewConstraints()
        configureTitleLabelConstraints()
        configureLastTwoWeeksNameLabelConstraints()
        configureOnRecordLabelConstraints()
    }
    
}

// MARK: - Themeable

extension PlayerGameCell: Themeable {
    
    func apply(theme: Theme) {
        titleLabel.textColor = theme.primaryTextColor
        lastTwoWeeksNameLabel.textColor = theme.primaryTextColor.withAlphaComponent(0.5)
        onRecordLabel.textColor = theme.primaryTextColor.withAlphaComponent(0.5)
        gamePicImageView.backgroundColor = theme.accentColor
    }
    
}

// MARK: - ConfigureCell

extension PlayerGameCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 120
    
    func configure(with viewModel: PlayerGameCellViewModel) {
        gamePicImageView.loadImage(url: viewModel.picUrl)
        titleLabel.text = viewModel.title
        lastTwoWeeksNameLabel.text = viewModel.lastTwoWeekPlayed
        onRecordLabel.text = viewModel.onRecordPlayed
    }
    
}

// MARK: - Constraints

private extension PlayerGameCell {
    
    func configureGamePicImageViewConstraints() {
        gamePicImageView.snp.remakeConstraints { make in
            make.height.equalTo(23)
            make.width.equalTo(61)
            make.top.equalToSuperview().inset(Constants.verticalMargin)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(gamePicImageView.snp.top).inset(Constants.titleLabelTop)
            make.leading.equalTo(gamePicImageView.snp.trailing).inset(Constants.titleLabelLeading)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureLastTwoWeeksNameLabelConstraints() {
        lastTwoWeeksNameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureOnRecordLabelConstraints() {
        onRecordLabel.snp.remakeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(lastTwoWeeksNameLabel.snp.bottom)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.bottom.equalToSuperview().inset(Constants.verticalMargin)
        }
    }
    
}
