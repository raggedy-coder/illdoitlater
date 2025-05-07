//
//  TodoListSection.swift
//  im so done
//
//  Created by RB de Guzman on 5/7/25.
//

import SwiftUI
import SwiftData

struct TodoListSection: View {
    @Environment(\.modelContext) private var context
    @State private var isExpanded: Bool = true
    
    var category: TodoListTableCategory
    var todos: [Todo]
    
    private func removeTodos(at indexes: IndexSet) {
        for index in indexes {
            context.delete(todos[index])
        }
        
        if context.hasChanges {
            try? context.save()
        }
    }
    
    var body: some View {
        Section(category.rawValue, isExpanded: $isExpanded) {
            ForEach(todos) { todo in
                NavigationLink {
                    TodoListDetailView(todo)
                } label: {
                    TodoListRow(todo)
                }
            }.onDelete { indexes in
                removeTodos(at: indexes)
            }
        }
    }
}
