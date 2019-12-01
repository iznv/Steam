//
//  BaseStatisticsProvider.swift
//  Steam
//
//  Created by Ivan Zinovyev on 01/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import ApiKit

private enum Constants {
    
    static let defaultValue = "0"
    
}

class BaseStatisticsProvider {
    
    // MARK: - Properties
    
    private let stats: [Stat]
    
    private let onStatTap: ((String) -> Void)
    
    // MARK: - Init
    
    init(stats: [Stat],
         onStatTap: @escaping (String) -> Void) {
        
        self.stats = stats
        self.onStatTap = onStatTap
    }

}

// MARK: - Public

extension BaseStatisticsProvider {
    
    func statItem(title: String,
                  name: String) -> TitleValueItem {
        
        return TitleValueItem(title: title,
                              value: stats.value(for: name)) { [weak self] in
            self?.onStatTap(name)
        }
    }
    
}

// MARK: - Private

private extension Array where Element == Stat {
    
    func value(for name: String) -> String {
        guard let value = self.value(for: name) else { return Constants.defaultValue }
        return NumberFormatter.common.string(from: NSNumber(value: value)) ?? Constants.defaultValue
    }
    
}
