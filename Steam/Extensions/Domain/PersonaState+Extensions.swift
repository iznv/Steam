//
//  PersonaState+Extensions.swift
//  Steam
//
//  Created by Ivan Zinovyev on 30/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import ApiKit

extension PersonaState {
    
    var title: String {
        switch self {
        case .offline:
            return R.string.localizable.profileOnlineStatusOffline()
        case .online:
            return R.string.localizable.profileOnlineStatusOnline()
        case .busy:
            return R.string.localizable.profileOnlineStatusBusy()
        case .away:
            return R.string.localizable.profileOnlineStatusAway()
        case .snooze:
            return R.string.localizable.profileOnlineStatusSnooze()
        case .lookingToTrade:
            return R.string.localizable.profileOnlineStatusLookingToTrade()
        case .lookingToPlay:
            return R.string.localizable.profileOnlineStatusLookingToPlay()
        }
    }
    
}
