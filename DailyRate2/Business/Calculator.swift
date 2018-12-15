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
    
}
