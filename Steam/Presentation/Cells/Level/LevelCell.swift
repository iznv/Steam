import TableKit
import Utils

class LevelCell: BaseTableViewCell {
    
    // MARK: - Views
    
    private let levelView: LevelView = {
        let levelView = LevelView()
        return levelView
    }()
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: contentView)
    }

    // MARK: - Views
    
    override func addViews() {
        contentView.addSubview(levelView)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureLevelViewConstraints()
    }
    
}

// MARK: - Themeable

extension LevelCell: Themeable {
    
    func apply(theme: Theme) {
        levelView.progressForegroundColor = theme.accentColor
        levelView.progressBackgroundColor = theme.primaryTextColor.withAlphaComponent(0.2)
        levelView.textColor = theme.primaryTextColor
    }
    
}

// MARK: - ConfigureCell

extension LevelCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 100
    
    func configure(with viewModel: LevelCellViewModel) {
        levelView.level = viewModel.level
        levelView.progressString = viewModel.progressString
        levelView.progress = viewModel.progress
    }
    
}

// MARK: - Constraints

private extension LevelCell {
    
    func configureLevelViewConstraints() {
        levelView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
