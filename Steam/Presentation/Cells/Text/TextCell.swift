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
    
    // MARK: - Views
    
    override func addViews() {
        contentView.addSubview(label)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureLabelConstraints()
    }
    
}

// MARK: - ConfigureCell

extension TextCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 44
    
    func configure(with viewModel: TextCellViewModel) {
        label.text = viewModel.text
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
