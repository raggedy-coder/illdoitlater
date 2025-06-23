//
//  EditTodoView.swift
//  illdoitlater
//
//  Created by RB de Guzman on 5/5/25.
//

import SwiftUI

struct EditTodoView: View {
    var todo: Todo

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var dueDateOption: DueDateOption
    
    init(_ todo: Todo) {
        self.todo = todo
        self._dueDateOption = .init(initialValue: todo.dueDateOption)
    }
    
    var body: some View {
        Form {
            Section {
                TodoRow(todo, isEditing: true)
            }
            Section {
                DueDatePicker(dueDateOption: $dueDateOption, dueDate: Binding(get: {
                    todo.dueDate ?? Date()
                }, set: { newValue, transaction in
                    todo.dueDate = newValue
                })).onChange(of: dueDateOption) { oldValue, newValue in
                    if dueDateOption != oldValue && dueDateOption != .pickDate {
                        todo.dueDate = dueDateOption.correspondingDate
                    }
                }
            }
            Section {
                HStack(alignment: .center, content: {
                    Button(Strings.delete, role: .destructive) {
                        context.delete(todo)
                        dismiss()
                    }
                })
            }
        }
        .listRowSeparator(.hidden)
        .onDisappear {
            if context.hasChanges {
                try? context.save()
            }
        }
    }
}

#Preview {
    let todo = Todo(text: "Walk the dog", dueDate: DueDateOption.nextWeek.correspondingDate)
    EditTodoView(todo)
}
