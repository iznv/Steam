//
//  CurrencyView.swift
//  ShotOne
//
//  Created by Ivan Zinovyev on 25/03/2019.
//  Copyright © 2019 Ivan Zinovyev. All rights reserved.
//

import SnapKit
import Utils

class ProgressView: BaseView {

    // MARK: - Constants

    private struct Constants {
    

    
    }
    
    // MARK: - Views
    
    private let progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    // MARK: - Constraints
    
    var trailingConstraint: Constraint?
    
    // MARK: - Properties

    var progress: CGFloat = 0 {
        didSet {
            trailingConstraint?.update(inset: frame.width - progress * frame.width)
        }
    }
    
    // MARK: - Init
    
    override func commonInit() {
        super.commonInit()
        
        backgroundColor = .darkGray
    }
    
    // MARK: - Subviews
    
    override func addViews() {
        addSubview(progressView)
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureProgressViewConstraints()
    }
    
}

// MARK: - Constraints

private extension ProgressView {
    
    func configureProgressViewConstraints() {
        progressView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            trailingConstraint = make.trailing.equalToSuperview().constraint
        }
    }

}
