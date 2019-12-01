//
//  CustomStatisticsProvider.swift
//  Steam
//
//  Created by Ivan Zinovyev on 01/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

protocol CustomStatisticsProvider {
    
    var statistics: [CustomStatistics] { get }
    
}
