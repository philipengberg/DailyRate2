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
    
    enum DaysInMonth: Int {
        case twentyEight = 28
        case thirty = 30
        case thirtyOne = 31
        
        var exampleMonth: Int {
            switch self {
            case .twentyEight:  return 2 // February
            case .thirty:       return 4 // April
            case .thirtyOne:    return 1 // January
            }
        }
    }
    
    enum TestDate {
        case firstDay
        case middleDay
        case secondToLast(daysInMonth: DaysInMonth)
        case lastDay(daysInMonth: DaysInMonth)
        
        var day: Int {
            switch self {
            case .firstDay:                      return 1
            case .middleDay:                     return 15
            case .secondToLast(let daysInMonth): return daysInMonth.rawValue - 1
            case .lastDay(let daysInMonth):      return daysInMonth.rawValue
            }
        }
        
        var date: Date {
            switch self {
            case .firstDay:                      return Date(year: 2018, month: 12, day: day, hour: 12, minute: 0, second: 0)
            case .middleDay:                     return Date(year: 2018, month: 12, day: day, hour: 12, minute: 0, second: 0)
            case .secondToLast(let daysInMonth): return Date(year: 2018, month: daysInMonth.exampleMonth, day: day, hour: 12, minute: 0, second: 0)
            case .lastDay(let daysInMonth):      return Date(year: 2018, month: daysInMonth.exampleMonth, day: day, hour: 12, minute: 0, second: 0)
            }
        }
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDailyRate() {
        
        let startAmount: Double = 2500
        
        // 31 days
        let rate1 = Calculator.calculateDailyRate(with: startAmount, at: TestDate.lastDay(daysInMonth: .thirtyOne).date)
        XCTAssertEqual(rate1, 80.65, accuracy: 0.01)
        
        // 30 days
        let rate2 = Calculator.calculateDailyRate(with: startAmount, at: TestDate.lastDay(daysInMonth: .thirty).date)
        XCTAssertEqual(rate2, 83.33, accuracy: 0.01)
        
        // 28 days
        let rate3 = Calculator.calculateDailyRate(with: startAmount, at: TestDate.lastDay(daysInMonth: .twentyEight).date)
        XCTAssertEqual(rate3, 89.28, accuracy: 0.01)
    }
    
    func testWeeklyRate() {
        let startAmount: Double = 5000
        
        // 31 days
        let rate1 = Calculator.calculateWeeklyRate(with: startAmount, at: TestDate.lastDay(daysInMonth: .thirtyOne).date)
        XCTAssertEqual(rate1, 1129.03, accuracy: 0.01)
        
        // 30 days
        let rate2 = Calculator.calculateWeeklyRate(with: startAmount, at: TestDate.lastDay(daysInMonth: .thirty).date)
        XCTAssertEqual(rate2, 1166.67, accuracy: 0.01)
        
        // 28 days
        let rate3 = Calculator.calculateWeeklyRate(with: startAmount, at: TestDate.lastDay(daysInMonth: .twentyEight).date)
        XCTAssertEqual(rate3, 1250, accuracy: 0.01)
    }
    
    func testTodaysDailyAmountFirstDayOfMonth() {
        
        let startAmount: Double = 2500
        
        // First day
        let date1         = TestDate.firstDay
        let dailyRate1    = Calculator.calculateDailyRate(with: startAmount, at: date1.date)
        let todaysAmount1 = Calculator.calculateTodaysDailyAmount(with: startAmount, at: date1.date, startDay: .firstDayOfMonth)
        XCTAssertEqual(todaysAmount1, startAmount - Double(date1.day) * dailyRate1, accuracy: 0.01)
        
        // Middle of month
        let date2         = TestDate.middleDay
        let dailyRate2    = Calculator.calculateDailyRate(with: startAmount, at: date2.date)
        let todaysAmount2 = Calculator.calculateTodaysDailyAmount(with: startAmount, at: date2.date, startDay: .firstDayOfMonth)
        XCTAssertEqual(todaysAmount2, startAmount - Double(date2.day) * dailyRate2, accuracy: 0.01)
        
        // Last day
        let date3         = TestDate.lastDay(daysInMonth: .thirtyOne)
        let todaysAmount3 = Calculator.calculateTodaysDailyAmount(with: startAmount, at: date3.date, startDay: .firstDayOfMonth)
        XCTAssertEqual(todaysAmount3, 0, accuracy: 0.01)
    }
    
    func testTodaysDailyAmountLastDayOfMonth() {
        
        let startAmount: Double = 2500
        
        // First day
        let date1         = TestDate.firstDay
        let dailyRate1    = Calculator.calculateDailyRate(with: startAmount, at: date1.date)
        let todaysAmount1 = Calculator.calculateTodaysDailyAmount(with: startAmount, at: date1.date, startDay: .lastDayOfMonth)
        XCTAssertEqual(todaysAmount1, startAmount - (Double(date1.day) + 1) * dailyRate1, accuracy: 0.01)
        
        // Middle of month
        let date2         = TestDate.middleDay
        let dailyRate2    = Calculator.calculateDailyRate(with: startAmount, at: date2.date)
        let todaysAmount2 = Calculator.calculateTodaysDailyAmount(with: startAmount, at: date2.date, startDay: .lastDayOfMonth)
        XCTAssertEqual(todaysAmount2, startAmount - (Double(date2.day) + 1) * dailyRate2, accuracy: 0.01)
        
        // Second to last day
        let date3         = TestDate.secondToLast(daysInMonth: .thirtyOne)
        let todaysAmount3 = Calculator.calculateTodaysDailyAmount(with: startAmount, at: date3.date, startDay: .lastDayOfMonth)
        XCTAssertEqual(todaysAmount3, 0, accuracy: 0.01)
        
        // Last day
        let date4         = TestDate.lastDay(daysInMonth: .thirtyOne)
        let dailyRate4    = Calculator.calculateDailyRate(with: startAmount, at: date4.date)
        let todaysAmount4 = Calculator.calculateTodaysDailyAmount(with: startAmount, at: date4.date, startDay: .lastDayOfMonth)
        XCTAssertEqual(todaysAmount4, startAmount - dailyRate4, accuracy: 0.01)
    }
    
    func testTodaysWeeklyAmount() {
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
