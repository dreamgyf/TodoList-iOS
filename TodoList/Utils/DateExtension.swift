//
//  DateExtension.swift
//  TodoList
//
//  Created by 高云峰 on 2020/11/23.
//

import Foundation

extension Date {
    
    public static var thisYear: String {
        get {
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy"
            return fmt.string(from: Date())
        }
    }
    
    static func getDays(year: Int, month: Int) -> Int {
        let calendar = Calendar.current
         
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
         
        var endComps = DateComponents()
        endComps.day = 1
        endComps.month = month == 12 ? 1 : month + 1
        endComps.year = month == 12 ? year + 1 : year
         
        let startDate = calendar.date(from: startComps)!
        let endDate = calendar.date(from: endComps)!
         
        let diff = calendar.dateComponents([.day], from: startDate, to: endDate)
        return diff.day ?? 0
    }
    
}
