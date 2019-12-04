import TableKit
import Utils

class GameCell: BaseTableViewCell {
    
    // MARK: - Views
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .medium16()
        return label
    }()
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: contentView)
    }
    
    // MARK: - Views
    
    override func addViews() {
        contentView.addSubview(nameLabel)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureNameLabelConstraints()
    }
    
}

// MARK: - Themeable

extension GameCell: Themeable {
    
    func apply(theme: Theme) {
        nameLabel.textColor = theme.primaryTextColor
    }
    
}

// MARK: - ConfigureCell

extension GameCell: ConfigurableCell {
    
    static let defaultHeight: CGFloat? = 48
    
    func configure(with viewModel: GameCellViewModel) {
        nameLabel.text = viewModel.name
    }
    
}

// MARK: - Constraints

private extension GameCell {
    
    func configureNameLabelConstraints() {
        nameLabel.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
}
