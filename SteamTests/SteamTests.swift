//
//  SteamTests.swift
//  SteamTests
//
//  Created by Ivan Zinovyev on 30/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import XCTest
@testable import Steam
@testable import ApiKit

class SteamTests: XCTestCase {

    override func setUp() { }

    override func tearDown() { }

}

extension SteamTests {
    
    func testProgress() {
        let levelCellViewModel = LevelCellViewModel(level: 3,
                                                    xpTotal: 324,
                                                    xpLeft: 76,
                                                    xpCurrentLevel: 300)
        
        XCTAssertEqual(levelCellViewModel.progressString, "324 / 400")
        XCTAssertEqual(levelCellViewModel.progress, 0.24)
    }
    
}
