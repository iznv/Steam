//
//  PubgStatisticsProvider.swift
//  Steam
//
//  Created by Ivan Zinovyev on 01/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import ApiKit

class PubgStatisticsProvider: BaseStatisticsProvider, CustomStatisticsProvider {
    
    var statistics: [CustomStatistics] {
        
        let chickenDinnerItems = [
            statItem(title: R.string.localizable.statPubgChickenDinnerSolo(),
                     name: "ACHIEVE001_ACHIEVE001"),
            statItem(title: R.string.localizable.statPubgChickenDinnerDuo(),
                     name: "ACHIEVE002_ACHIEVE002"),
            statItem(title: R.string.localizable.statPubgChickenDinnerSquad(),
                     name: "ACHIEVE003_ACHIEVE003")
        ]
        
        let topTenItems = [
            statItem(title: R.string.localizable.statPubgTopTenTenTimes(),
                     name: "ACHIEVE004_ACHIEVE004"),
            statItem(title: R.string.localizable.statPubgTopTenWithoutKilling(),
                     name: "ACHIEVE005_ACHIEVE005")
        ]
        
        let cqbItems = [
            statItem(title: R.string.localizable.statPubgNovice(),
                     name: "ACHIEVE008_ACHIEVE008"),
            statItem(title: R.string.localizable.statPubgExpert(),
                     name: "ACHIEVE007_ACHIEVE007"),
            statItem(title: R.string.localizable.statPubgMaster(),
                     name: "ACHIEVE006_ACHIEVE006")
        ]
        
        let marksmanItems = [
            statItem(title: R.string.localizable.statPubgNovice(),
                     name: "ACHIEVE011_ACHIEVE011"),
            statItem(title: R.string.localizable.statPubgExpert(),
                     name: "ACHIEVE010_ACHIEVE010"),
            statItem(title: R.string.localizable.statPubgMaster(),
                     name: "ACHIEVE009_ACHIEVE009")
        ]
        
        let nadeKingItems = [
            statItem(title: R.string.localizable.statPubgNovice(),
                     name: "ACHIEVE014_ACHIEVE014"),
            statItem(title: R.string.localizable.statPubgExpert(),
                     name: "ACHIEVE013_ACHIEVE013"),
            statItem(title: R.string.localizable.statPubgMaster(),
                     name: "ACHIEVE012_ACHIEVE012")
        ]
        
        let anyMeansItems = [
            statItem(title: R.string.localizable.statPubgAnyMeansOne(),
                     name: "ACHIEVE018_ACHIEVE018"),
            statItem(title: R.string.localizable.statPubgAnyMeansTen(),
                     name: "ACHIEVE017_ACHIEVE017"),
            statItem(title: R.string.localizable.statPubgAnyMeansHundred(),
                     name: "ACHIEVE016_ACHIEVE016"),
            statItem(title: R.string.localizable.statPubgAnyMeansThousand(),
                     name: "ACHIEVE015_ACHIEVE015")
        ]
        
        return [
            CustomStatistics(icon: R.image.statIconPubgChickenDinner(),
                             title: R.string.localizable.statPubgChickenDinner(),
                             items: chickenDinnerItems),
            CustomStatistics(icon: R.image.statIconPubgTopTen(),
                             title: R.string.localizable.statPubgTopTen(),
                             items: topTenItems),
            CustomStatistics(icon: R.image.statIconPubgCQB(),
                             title: R.string.localizable.statPubgCloseQuartersBattle(),
                             items: cqbItems),
            CustomStatistics(icon: R.image.statIconPubgMarksman(),
                             title: R.string.localizable.statPubgMarksman(),
                             items: marksmanItems),
            CustomStatistics(icon: R.image.statIconPubgNadeKing(),
                             title: R.string.localizable.statPubgNadeKing(),
                             items: nadeKingItems),
            CustomStatistics(icon: R.image.statIconPubgAnyMeans(),
                             title: R.string.localizable.statPubgAnyMeans(),
                             items: anyMeansItems)
        ]
        
    }
    
}
