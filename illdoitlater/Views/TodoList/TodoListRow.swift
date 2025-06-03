//
//  TodoListRow.swift
//  illdoitlater
//
//  Created by RB de Guzman on 5/4/25.
//

import SwiftUI

struct TodoListRow: View {
    @Bindable var todo: Todo
    var isEditing: Bool = false
    
    init(_ todo: Todo, isEditing: Bool = false) {
        self.todo = todo
        self.isEditing = isEditing
    }
    
    private func displayableDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
    
    private func toggle() {
        todo.isCompleted.toggle()
        try? todo.modelContext?.save()
    }
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .padding([.top, .bottom])
                    .contentShape(Rectangle())
                    .onTapGesture {
                        toggle()
                    }
            }
            
            VStack(alignment: .leading, content: {
                if isEditing {
                    TextField(Strings.newTodoPlaceholder, text: $todo.text)
                } else {
                    Text(todo.text).strikethrough(todo.isCompleted)
                    if let date = todo.dueDate {
                        Text(displayableDate(date))
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
                
            })
        }
    }
}
