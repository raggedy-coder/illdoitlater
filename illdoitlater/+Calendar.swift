//
//  +Calendar.swift
//  illdoitlater
//
//  Created by RB de Guzman on 5/5/25.
//

import Foundation

extension Calendar {
    func isDatePast(_ date: Date) -> Bool {
        date.stripped() < Date().stripped()
    }
    
    func isDateAfterTomorrow(_ date: Date) -> Bool {
        date.stripped() > Date.tomorrow.stripped()
    }
    
    func isDateInNextWeek(_ date: Date) -> Bool {
        date.stripped() > Date.nextWeek.stripped()
    }
}
