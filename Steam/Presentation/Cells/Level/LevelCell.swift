import TableKit
import Utils

class LevelCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let progressViewTop: CGFloat = -10
        
        static let progressLabelLeading: CGFloat = -12
        
        static let verticalMargin: CGFloat = 8
        
    }
    
    // MARK: - Views
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.font = .medium26()
        return label
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = .medium12()
        return label
    }()
    
    private let progressView: ProgressView = {
        let view = ProgressView()

        return view
    }()
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: contentView)
    }

    // MARK: - Views
    
    override func addViews() {
        contentView.addSubviews(
            levelLabel,
            progressLabel,
            progressView
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureLevelLabelConstraints()
        configureProgressLabelConstraints()
        configureProgressViewConstraints()
    }
    
}

// MARK: - Themeable

extension LevelCell: Themeable {
    
    func apply(theme: Theme) {
        levelLabel.textColor = theme.primaryTextColor
        progressLabel.textColor = theme.primaryTextColor.withAlphaComponent(0.5)
    }
    
}

// MARK: - ConfigureCell

extension LevelCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 100
    
    func configure(with viewModel: LevelCellViewModel) {
        levelLabel.text = viewModel.level
        progressLabel.text = viewModel.progressString
        progressView.progress = viewModel.progress
    }
    
}

// MARK: - Constraints

private extension LevelCell {
    
    func configureLevelLabelConstraints() {
        levelLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(Constants.verticalMargin)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureProgressLabelConstraints() {
        progressLabel.snp.remakeConstraints { make in
            make.leading.equalTo(progressView.snp.trailing).inset(Constants.progressLabelLeading)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.centerY.equalTo(progressView.snp.centerY)
        }
    }
    
    func configureProgressViewConstraints() {
        progressView.snp.remakeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).inset(Constants.progressViewTop)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.height.equalTo(CGFloat.progressBarHeight)
            make.bottom.equalToSuperview().inset(Constants.verticalMargin)
        }
    }
    
}
