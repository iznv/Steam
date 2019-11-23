//
//  CurrencyView.swift
//  ShotOne
//
//  Created by Ivan Zinovyev on 25/03/2019.
//  Copyright © 2019 Ivan Zinovyev. All rights reserved.
//

import Utils

class TitleValueView: BaseView {

    // MARK: - Constants

    private struct Constants {
    

    
    }
    
    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // MARK: Properties
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var value: Int? {
        didSet {
            valueLabel.text = value.map { String($0) }
        }
    }
    
    // MARK: - Subviews
    
    override func addViews() {
        addSubviews(
            titleLabel,
            valueLabel
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureTitleLabelConstraints()
        configureValueLabelConstraints()
    }
    
}

// MARK: - Constraints

private extension TitleValueView {
    
    func configureTitleLabelConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.leading.top.equalToSuperview()
        }
    }
    
    func configureValueLabelConstraints() {
        valueLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview().priority(.low)
        }
    }

}
