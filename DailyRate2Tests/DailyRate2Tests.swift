//
//  DailyRate2Tests.swift
//  DailyRate2Tests
//
//  Created by Philip Engberg on 15/12/2018.
//  Copyright © 2018 Simple Sense. All rights reserved.
//

import XCTest
@testable import DailyRate2

class DailyRate2Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDailyRate() {
        
        // 31 days
        let rate1 = Calculator.calculateDailyRate(with: 2500, at: Date(year: 2018, month: 12, day: 1, hour: 12, minute: 0, second: 0))
        XCTAssertEqual(rate1, 80.65, accuracy: 0.01)
        
        // 30 days
        let rate2 = Calculator.calculateDailyRate(with: 2500, at: Date(year: 2018, month: 11, day: 1, hour: 12, minute: 0, second: 0))
        XCTAssertEqual(rate2, 83.33, accuracy: 0.01)
        
        // 28 days
        let rate3 = Calculator.calculateDailyRate(with: 2500, at: Date(year: 2018, month: 2, day: 1, hour: 12, minute: 0, second: 0))
        XCTAssertEqual(rate3, 89.28, accuracy: 0.01)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
