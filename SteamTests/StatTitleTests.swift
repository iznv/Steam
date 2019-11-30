//
//  StatTitleTests.swift
//  SteamTests
//
//  Created by Ivan Zinovyev on 30/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import XCTest

@testable import Steam
@testable import ApiKit

private enum Constants {
    
    static let statTitle = "Stat Total Wins"
    
}

class StatTitleTests: XCTestCase {

    override func setUp() { }

    override func tearDown() { }

}

extension StatTitleTests {
    
    func testStatTitle1() {
        let stat = SchemaStat(name: "STAT_TOTAL_WINS", defaultValue: 100, displayName: .empty)
        XCTAssertEqual(stat.title, Constants.statTitle)
    }
    
    func testStatTitle2() {
        let stat = SchemaStat(name: .empty, defaultValue: 100, displayName: "STAT_TOTAL_WINS")
        XCTAssertEqual(stat.title, Constants.statTitle)
    }
    
    func testStatTitle3() {
        let stat = SchemaStat(name: .empty, defaultValue: 100, displayName: "STAT TOTAL WINS")
        XCTAssertEqual(stat.title, Constants.statTitle)
    }
    
    func testStatTitle4() {
        let stat = SchemaStat(name: "STAT TOTAL WINS", defaultValue: 100, displayName: .empty)
        XCTAssertEqual(stat.title, Constants.statTitle)
    }
    
    func testStatTitle5() {
        let stat = SchemaStat(name: "stat_total wins", defaultValue: 100, displayName: .empty)
        XCTAssertEqual(stat.title, Constants.statTitle)
    }
    
    func testStatTitle6() {
        let stat = SchemaStat(name: .empty, defaultValue: 100, displayName: "stat total_wins")
        XCTAssertEqual(stat.title, Constants.statTitle)
    }
    
    func testStatTitle7() {
        let stat = SchemaStat(name: Constants.statTitle, defaultValue: 100, displayName: .empty)
        XCTAssertEqual(stat.title, Constants.statTitle)
    }
    
    func testStatTitle8() {
        let stat = SchemaStat(name: .empty, defaultValue: 100, displayName: Constants.statTitle)
        XCTAssertEqual(stat.title, Constants.statTitle)
    }
    
}
