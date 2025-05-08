//
//  TodoListView.swift
//  illdoitlater
//
//  Created by RB de Guzman on 12/28/24.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    @Query(sort: \Todo.dueDate) private var todos: [Todo]
    
    private func TodoListHeader() -> some View {
        return VStack {
            Text(Date().formatted(Date.FormatStyle().weekday(.wide))).font(.title2)
            Text(Date().formatted(Date.FormatStyle().month(.wide).day()))
        }.padding()
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                TodoListHeader()
                TodoListTable(todos)
                TodoListFooter()
            }.navigationDestination(for: Todo.self) { todo in
                TodoListDetailView(todo)
            }
        }
    }
}

#Preview {
    TodoListView()
}
