import TableKit
import Utils

class PlayerGameCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let picCornerRadius: CGFloat = 4
        
        static let gamePicImageViewSize: CGFloat = 32
        
        static let titleLabelLeading: CGFloat = -10
        
    }
    
    // MARK: - Views
    
    private let gamePicImageView: UIImageView = {
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
    
    private let lastTwoWeeksNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let onRecordLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
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
            make.top.equalToSuperview().inset(CGFloat.verticalMargin)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.size.equalTo(Constants.gamePicImageViewSize)
        }
    }
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(gamePicImageView.snp.top)
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
            make.bottom.equalToSuperview().inset(CGFloat.verticalMargin)
        }
    }
    
}
