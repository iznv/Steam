//
//  ViewState.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import UIKit

// MARK: - Default States

enum ViewState: String, CaseIterable {

    case loading
    
    case somethingWrong
    
    case noConnection
    
    case empty

}

extension ViewState {

    func makeDefaultView(delegate: DefaultStatesDelegate?) -> UIView? {
        switch self {
        case .loading:
            return makeLoadingView()
        case .somethingWrong:
            return makeSomethingWrongView(delegate: delegate)
        case .noConnection:
            return makeNoConnectionView(delegate: delegate)
        case .empty:
            return makeEmptyView()
        }
    }

}

// MARK: - Views Factory Methods

private extension ViewState {

    func makeLoadingView() -> UIView {
        return LoadingStateView()
    }
    
    func makeSomethingWrongView(delegate: DefaultStatesDelegate?) -> UIView {
        let view = CustomStateView()
        view.stateDescription = R.string.localizable.stateSomethingWrongDescription()
        view.buttonTitle = R.string.localizable.stateRetry()
        view.didTapButton = {
            delegate?.didTapRetry(view: view)
        }
        return view
    }
    
    func makeNoConnectionView(delegate: DefaultStatesDelegate?) -> UIView {
        let view = CustomStateView()
        view.stateDescription = R.string.localizable.stateNoConnectionDescription()
        view.buttonTitle = R.string.localizable.stateRetry()
        view.didTapButton = {
            delegate?.didTapRetry(view: view)
        }
        return view
    }
    
    func makeEmptyView() -> UIView {
        let view = DescriptionStateView()
        view.stateDescription = R.string.localizable.stateEmptyDescription()
        return view
    }

}
