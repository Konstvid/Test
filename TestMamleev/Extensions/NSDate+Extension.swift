//
//  NSDate+Extension.swift
//  TestMamleev
//
//  Created by Andrey on 19.02.2023.
//

import Foundation

extension NSDate {
    
    func isOpen(start: WorkingHours, finish: WorkingHours) -> Bool {
        let calendar = Calendar.current
        let currentDateValue = self as Date
        let todayAtAM = calendar.date(bySettingHour: start.hours, minute: start.minutes, second: 0, of: currentDateValue)
        let todayAtPM = calendar.date(bySettingHour: finish.hours, minute: finish.minutes, second: 0, of: currentDateValue)
        return currentDateValue >= todayAtAM! && currentDateValue <= todayAtPM!
    }
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
