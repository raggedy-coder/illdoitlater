//
//  TodoListRow.swift
//  illdoitlater
//
//  Created by RB de Guzman on 5/4/25.
//

import SwiftUI
import SwiftData

struct TodoListRow: View {
    @Environment(\.modelContext) private var context
    var todo: Todo
    
    init(_ todo: Todo) {
        self.todo = todo
    }
    
    private func displayableDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
    
    private func toggle() {
        todo.isCompleted.toggle()
        context.insert(todo)
        if context.hasChanges {
            try? context.save()
        }
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
                Text(todo.text).strikethrough(todo.isCompleted)
                if let date = todo.dueDate {
                    Text(displayableDate(date)).font(.caption).foregroundStyle(.gray)
                }
            })
        }
    }
}
