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
    @State private var showingNewTodoView = false
    
    private func TodoListHeader() -> some View {
        return VStack {
            Text(Date().formatted(Date.FormatStyle().weekday(.wide))).font(.title2)
            Text(Date().formatted(Date.FormatStyle().month(.wide).day()))
        }.padding()
    }
    
    fileprivate func TodoListFooter() -> some View {
        return HStack {
            Button("New To Do", systemImage: "plus.circle") {
                showingNewTodoView.toggle()
            }.sheet(isPresented: $showingNewTodoView) {
                NewTodoView()
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                TodoListHeader()
                TodoListTable(todos)
                TodoListFooter()
            }
        }
    }
}

#Preview {
    TodoListView()
}
