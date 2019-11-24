//
//  FormattingService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 24/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

private enum Constants {

    static let minutesInHour = 60.0
    
}

class FormattingService {
    
    func timePlayed(timeInMinutes: Int) -> String? {
        let timeInHours = Double(timeInMinutes) / Constants.minutesInHour
        
        if timeInHours < 1 {
            let time = NumberFormatter.playedTime.string(from: NSNumber(value: Double(timeInMinutes)))
            return time.map { R.string.localizable.activityMinutesPastTwoWeeksFormat($0) }
        } else {
            let time = NumberFormatter.playedTime.string(from: NSNumber(value: timeInHours))
            return time.map { R.string.localizable.activityHoursPastTwoWeeksFormat($0) }
        }
    }
    
}
