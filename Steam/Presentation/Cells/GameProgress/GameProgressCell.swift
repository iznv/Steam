import TableKit
import Utils

class GameProgressCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let progressBarTop: CGFloat = -10
        
    }
    
    // MARK: - Views
    
    private let progressView: ProgressView = {
        let view = ProgressView()

        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.gameStatisticsAchievementProgress()
        return label
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()

        return label
    }()
    
    // MARK: - Views
    
    override func addViews() {
        contentView.addSubviews(
            progressView,
            titleLabel,
            progressLabel
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureProgressViewConstraints()
        configureTitleLabelConstraints()
        configureProgressLabelConstraints()
    }
    
}

// MARK: - ConfigureCell

extension GameProgressCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 60
    
    func configure(with viewModel: GameProgressCellViewModel) {
        progressView.progress = viewModel.progressValue
        progressLabel.text = viewModel.progressString
    }
    
}

// MARK: - Constraints

private extension GameProgressCell {
    
    func configureProgressViewConstraints() {
        progressView.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(Constants.progressBarTop)
            make.height.equalTo(CGFloat.progressBarHeight)
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.bottom.equalToSuperview().inset(CGFloat.verticalMargin).priority(.low)
        }
    }

    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(CGFloat.verticalMargin)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureProgressLabelConstraints() {
        progressLabel.snp.remakeConstraints { make in
            make.firstBaseline.equalTo(titleLabel.snp.firstBaseline)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
}
