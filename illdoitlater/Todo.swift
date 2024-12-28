//
//  Todo.swift
//  illdoitlater
//
//  Created by RB de Guzman on 12/27/24.
//

import Foundation
import SwiftData

@Model
final class Todo {
    var uid: String
    
    init(uid: String?) {
        self.uid = uid ?? UUID().uuidString
    }
}
