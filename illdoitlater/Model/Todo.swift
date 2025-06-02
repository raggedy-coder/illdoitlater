//
//  Todo.swift
//  illdoitlater
//
//  Created by RB de Guzman on 12/27/24.
//

import Foundation
import SwiftData

@Model
class Todo {
    @Attribute(.unique) var uid: String
    var text: String
    var dueDate: Date?
    var isCompleted: Bool
    
    init(uid: String? = nil, text: String, dueDate: Date? = nil, isCompleted: Bool = false) {
        self.uid = uid ?? UUID().uuidString
        self.text = text
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}

extension Array where Element: Todo {
    var notCompleted: [Todo] {
        filter({ !$0.isCompleted })
    }
    
    var completed: [Todo] {
        filter({ $0.isCompleted })
    }
    
    var withDueDates: [Todo] {
        filter({ $0.dueDate != nil })
    }
    
    var noDueDates: [Todo] {
        filter({ $0.dueDate == nil })
    }
    
    var pastDue: [Todo] {
        withDueDates.filter({ Calendar.current.isDatePast($0.dueDate!) })
    }
    
    var today: [Todo] {
        withDueDates.filter({ $0.dueDate!.isInToday })
    }
    
    var tomorrow: [Todo] {
        withDueDates.filter({ $0.dueDate!.isInTomorrow })
    }
    
    var upcoming: [Todo] {
        withDueDates.filter({ $0.dueDate!.isInUpcoming })
    }
    
    var nextWeek: [Todo] {
        withDueDates.filter({ $0.dueDate!.isInNextWeek })
    }
}

