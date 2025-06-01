//
//  TodoListDetailView.swift
//  illdoitlater
//
//  Created by RB de Guzman on 5/5/25.
//

import SwiftUI

fileprivate extension Todo {
    var dueDateOption: DueDateOption {
        if let dueDate = dueDate {
            if dueDate.isInUpcoming { return .pickDate }
            if dueDate.isInNextWeek { return .nextWeek }
            if dueDate.isInTomorrow { return .tomorrow }
            if dueDate.isInToday { return .today }
            return .pickDate
        } else {
            return .none
        }
    }
}

struct TodoListDetailView: View {
    @Bindable private var todo: Todo
    @State private var dueDateOption: DueDateOption
    
    init(_ todo: Todo) {
        @Bindable var _todo = todo
        self.todo = _todo
        
        self.dueDateOption = todo.dueDateOption
    }
    
    var dueDateOptionAdapter: Binding<DueDateOption> {
        Binding<DueDateOption>(get: { dueDateOption }, set: { dueDateOption = $0 })
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TodoListRow(todo, isEditing: true)
                }
                Section {
                    HStack(alignment: .center, content: {
                        Spacer()
                        Text("Due date")
                        
                        Picker("", selection: dueDateOptionAdapter) {
                            ForEach (DueDateOption.allCases) {
                                Text($0.text).tag($0)
                            }
                        }
                    })
                    HStack(alignment: .center, content: {
                        Spacer()
                        Text("")
                        DatePicker("", selection: Binding<Date>(get: {
                            if let date = todo.dueDate {
                                return date
                            } else {
                                return Date()
                            }
                        }, set: {
                            self.todo.dueDate = $0
                        }), displayedComponents: [.date])
                    })
                }.listRowSeparator(.hidden)
            }
            
        }
    }
}

#Preview {
    TodoListDetailView(Todo(text: "Sample todo", dueDate: Date(), isCompleted: false))
}
