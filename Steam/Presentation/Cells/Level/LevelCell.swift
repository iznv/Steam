import TableKit
import Utils

class LevelCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let progressViewHeight: CGFloat = 5
        
    }
    
    // MARK: - Views
    
    private let levelLabel: UILabel = {
        let label = UILabel()

        return label
    }()
    
    private let xpTotalLabel: UILabel = {
        let label = UILabel()

        return label
    }()
    
    private let progressView: ProgressView = {
        let view = ProgressView()

        return view
    }()
    
    private let xpLeftLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    // MARK: - Views
    
    override func addViews() {
        contentView.addSubviews(
            levelLabel,
            xpTotalLabel,
            progressView,
            xpLeftLabel
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureLevelLabelConstraints()
        configureXpTotalLabelConstraints()
        configureProgressViewConstraints()
        configureXpLeftLabelConstraints()
    }
    
}

// MARK: - ConfigureCell

extension LevelCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 100
    
    func configure(with viewModel: LevelCellViewModel) {
        levelLabel.text = viewModel.level
        xpTotalLabel.text = viewModel.xpTotal
        xpLeftLabel.text = viewModel.xpLeft
        progressView.progress = viewModel.progress
    }
    
}

// MARK: - Constraints

private extension LevelCell {
    
    func configureLevelLabelConstraints() {
        levelLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(CGFloat.verticalMargin)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureXpTotalLabelConstraints() {
        xpTotalLabel.snp.remakeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom)
            make.leading.equalTo(levelLabel.snp.leading)
        }
    }
    
    func configureProgressViewConstraints() {
        progressView.snp.remakeConstraints { make in
            make.top.equalTo(xpTotalLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.height.equalTo(Constants.progressViewHeight)
        }
    }
    
    func configureXpLeftLabelConstraints() {
        xpLeftLabel.snp.remakeConstraints { make in
            make.top.equalTo(progressView.snp.bottom)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.bottom.equalToSuperview().inset(CGFloat.verticalMargin)
        }
    }
    
}
