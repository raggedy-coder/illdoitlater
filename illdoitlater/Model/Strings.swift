//
//  Strings.swift
//  im so done
//
//  Created by RB de Guzman on 5/13/25.
//

import Foundation

enum Strings {
    static let cancel = "Cancel"
    static let confirm = "Confirm"
    static let currentWeekday = Date().formatted(Date.FormatStyle().weekday(.wide))
    static let currentMonthAndDay = Date().formatted(Date.FormatStyle().month(.wide).day())
    static let delete = "Delete"
    static let newTodoPlaceholder = "What do you need to do?"
}
