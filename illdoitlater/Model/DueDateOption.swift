//
//  DueDateOption.swift
//  im so done
//
//  Created by RB de Guzman on 6/1/25.
//

import Foundation

enum DueDateOption: String, CaseIterable, Identifiable {
    case none, today, tomorrow, nextWeek, pickDate
    var id: Self { self }
    
    var text: String {
        switch self {
        case .none: return "None"
        case .today: return "Today"
        case .tomorrow: return "Tomorrow"
        case .nextWeek : return "Next Week"
        case .pickDate: return "Pick Date"
        }
    }
    
    var correspondingDate: Date? {
        switch self {
        case .none: return nil
        case .today: return Date.today
        case .tomorrow: return Date.tomorrow
        case .nextWeek: return Date.nextWeek
        case .pickDate: return nil
        }
    }
}
