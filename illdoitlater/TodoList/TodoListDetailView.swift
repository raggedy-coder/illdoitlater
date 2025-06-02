//
//  TodoListDetailView.swift
//  illdoitlater
//
//  Created by RB de Guzman on 5/5/25.
//

import SwiftUI

struct TodoListDetailView: View {
    var todo: Todo
    @State private var dueDateOption: DueDateOption
    
    init(_ todo: Todo) {
        self.todo = todo
        self._dueDateOption = .init(initialValue: todo.dueDateOption)
    }
    
    var body: some View {
        Form {
            Section {
                TodoListRow(todo, isEditing: true)
            }
            Section {
                DueDatePicker(dueDateOption: $dueDateOption, dueDate: Binding(get: {
                    todo.dueDate ?? Date()
                }, set: { newValue, transaction in
                    print("Setting new todo.dueDate")
                    todo.dueDate = newValue
                    try? todo.modelContext?.save()
                })).onChange(of: dueDateOption) { oldValue, newValue in
                    print("Setting new todo.dueDate via dueDateOption")
                    if dueDateOption != oldValue && dueDateOption != .pickDate {
                        todo.dueDate = dueDateOption.correspondingDate
                        try? todo.modelContext?.save()
                    }
                }
            }
        }.listRowSeparator(.hidden)
            .onDisappear {
        }
    }
}

#Preview {
    let todo = Todo(text: "Do something")
    TodoListDetailView(todo)
}
