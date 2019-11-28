import SnapKit
import TableKit
import Utils

class TextCell: BaseTableViewCell {

    // MARK: - Views
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Properties
    
    private var viewModel: TextCellViewModel?
    
    // MARK: - Views
    
    override func addViews() {
        contentView.addSubview(label)
    }
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        enableTheme(for: self)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureLabelConstraints()
    }
    
}

// MARK: - Themeable

extension TextCell: Themeable {
    
    func apply(theme: Theme) {
        label.textColor = viewModel?.color?(theme) ?? theme.primaryTextColor
    }
    
}

// MARK: - ConfigureCell

extension TextCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 44
    
    func configure(with viewModel: TextCellViewModel) {
        self.viewModel = viewModel
        
        label.text = viewModel.text
        label.font = viewModel.font
        
        forceApplyTheme()
    }
    
}

// MARK: - Constraints

private extension TextCell {
    
    func configureLabelConstraints() {
        label.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview().inset(CGFloat.verticalMargin)
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
}
