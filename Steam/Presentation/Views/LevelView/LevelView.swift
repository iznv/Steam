//
//  LevelView.swift
//  Steam
//
//  Created by Ivan Zinovyev on 03/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import SnapKit
import Utils

class LevelView: BaseView {
    
    // MARK: - Constants
    
    private enum Constants {
        
        static let progressViewTop: CGFloat = -10
        
        static let progressLabelLeading: CGFloat = -12
        
        static let verticalMargin: CGFloat = 8
        
    }
    
    // MARK: - Views
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.font = .medium26()
        return label
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = .medium12()
        return label
    }()
    
    private let progressView: ProgressView = {
        let view = ProgressView()

        return view
    }()
    
    // MARK: - Properties
    
    var level: String? {
        didSet {
            levelLabel.text = level
        }
    }
    
    var progress: CGFloat = 0 {
        didSet {
            progressView.progress = progress
        }
    }
    
    var progressString: String? {
        didSet {
            progressLabel.text = progressString
        }
    }
    
    var progressForegroundColor: UIColor? {
        didSet {
            progressView.foregroundColor = progressForegroundColor
        }
    }
    
    var progressBackgroundColor: UIColor? {
        didSet {
            progressView.backgroundColor = progressBackgroundColor
        }
    }
    
    var textColor: UIColor? {
        didSet {
            [levelLabel, progressLabel].forEach { $0.textColor = textColor }
        }
    }
    
    // MARK: - Views
    
    override func addViews() {
        addSubviews(
            levelLabel,
            progressLabel,
            progressView
        )
    }
    
    // MARK: - Constraints
    
    override func configureConstraints() {
        configureLevelLabelConstraints()
        configureProgressLabelConstraints()
        configureProgressViewConstraints()
    }
    
}

// MARK: - Constraints

private extension LevelView {
    
    func configureLevelLabelConstraints() {
        levelLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(Constants.verticalMargin)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
        }
    }
    
    func configureProgressLabelConstraints() {
        progressLabel.snp.remakeConstraints { make in
            make.leading.equalTo(progressView.snp.trailing).inset(Constants.progressLabelLeading)
            make.trailing.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.centerY.equalTo(progressView.snp.centerY)
        }
    }
    
    func configureProgressViewConstraints() {
        progressView.snp.remakeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).inset(Constants.progressViewTop)
            make.leading.equalToSuperview().inset(CGFloat.horizontalMargin)
            make.height.equalTo(CGFloat.progressBarHeight)
            make.bottom.equalToSuperview().inset(Constants.verticalMargin)
        }
    }
    
}
