import TableKit
import Utils

class TitleDisclosureCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()

    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        accessoryType = .disclosureIndicator
    }
    
    // MARK: - Views
    
    override func addViews() {
        contentView.addSubview(titleLabel)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureTitleLabelConstraints()
    }
    
}

// MARK: - ConfigureCell

extension TitleDisclosureCell: ConfigurableCell {
    
    static let defaultHeight: CGFloat? = 44
    
    func configure(with viewModel: TitleDisclosureCellViewModel) {
        titleLabel.text = viewModel.title
    }
    
}

// MARK: - Constraints

private extension TitleDisclosureCell {
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
}
