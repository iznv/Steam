import TableKit
import Utils

class TitleValueCollectionCell: BaseTableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        
        
        
    }
    
    // MARK: - Views
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        return view
    }()
    
    // MARK: - Views
    
    override func addViews() {
        contentView.addSubview(stackView)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureStackViewConstraints()
    }
    
}

// MARK: - ConfigureCell

extension TitleValueCollectionCell: ConfigurableCell {
    
    static let estimatedHeight: CGFloat? = 70
    
    func configure(with viewModel: TitleValueCollectionCellViewModel) {
        viewModel.items.forEach { item in
            let titleValueView = TitleValueView()
            titleValueView.title = item.title
            titleValueView.value = item.value
            stackView.addArrangedSubview(titleValueView)
        }
    }
    
}

// MARK: - Constraints

private extension TitleValueCollectionCell {
    
    func configureStackViewConstraints() {
        stackView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
}
