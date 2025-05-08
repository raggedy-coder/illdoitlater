//
//  TodoListDetailView.swift
//  illdoitlater
//
//  Created by RB de Guzman on 5/5/25.
//

import SwiftUI

struct TodoListDetailView: View {
    var todo: Todo
    
    init(_ todo: Todo) {
        self.todo = todo
    }
    
    var body: some View {
        Text("Coming next!")
    }
}
