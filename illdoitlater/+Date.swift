//
//  +Date.swift
//  illdoitlater
//
//  Created by RB de Guzman on 4/29/25.
//

import Foundation

extension Date {
    static var today: Date {
        Date()
    }
    
    static var tomorrow: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    }
    
    static var nextWeek: Date {
        Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!
    }
    
    func stripped(components: Set<Calendar.Component> = [.year, .month, .day]) -> Date {
        let dateComponents = Calendar.current.dateComponents(components, from: self)
        return Calendar.current.date(from: dateComponents) ?? self
    }
    
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isInTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    var isInNextWeek: Bool {
        return Calendar.current.isDateInNextWeek(self)
    }
    
    var isInUpcoming: Bool {
        return Calendar.current.isDateAfterTomorrow(self)
    }
}


