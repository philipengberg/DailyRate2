//
//  Calculator.swift
//  DailyRate2
//
//  Created by Philip Engberg on 15/12/2018.
//  Copyright © 2018 Simple Sense. All rights reserved.
//

import Foundation
import DateToolsSwift

class Calculator {
    
    static func calculateDailyRate(with startAmount: Double, at date: Date) -> Double {
        return startAmount / Double(date.daysInMonth)
    }
    
    static func calculateWeeklyRate(with startAmount: Double, at date: Date) -> Double {
        return (startAmount / Double(date.daysInMonth)) * 7
    }
    
    static func calculateTodaysDailyAmount(with startAmount: Double, at date: Date, startDay: Account.StartDay) -> Double {
        
        let dailyRate = calculateDailyRate(with: startAmount, at: date)
        
        let adjustedDate: Date
        switch startDay {
        case .lastDayOfMonth:   adjustedDate = date.add(TimeChunk(days: 1))
        case .firstDayOfMonth:  adjustedDate = date
        }
        
        let todaysAmount = startAmount - (Double(adjustedDate.day) * dailyRate)
        return max(0, todaysAmount)
    }
    
    static func calculateTodaysWeeklyAmount(with startAmount: Double, at date: Date, startDay: Account.StartDay) -> Double {
        let weeklyIntervalStartDay = 1
        var daysToAdd = ((7 - (date.weekday-1)) + weeklyIntervalStartDay) % 7
        
        if startDay == .lastDayOfMonth {
            daysToAdd += 1
        }
        
        let offsetDate = date.add(TimeChunk(days: daysToAdd))
        
        return calculateTodaysDailyAmount(with:startAmount, at:offsetDate, startDay: .firstDayOfMonth)
    }
    
}
