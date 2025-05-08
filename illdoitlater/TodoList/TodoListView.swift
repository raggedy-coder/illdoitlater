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
    @State private var expandedCategories: Set<TodoListTableCategory> = Set([.today, .tomorrow, .upcoming, .eventually])
    
    private func TodoListHeader() -> some View {
        return VStack {
            Text(Date()
                .formatted(Date.FormatStyle().weekday(.wide))).font(.title2)
            Text(Date().formatted(Date.FormatStyle().month(.wide).day()))
        }.padding()
    }
    
    func collapseSections() {
        expandedCategories.removeAll()
    }
    
    func expandSections() {
        expandedCategories = Set(TodoListTableCategory.allCases)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                TodoListHeader()
                TodoListTable(todos, expandedCategories: $expandedCategories)
                TodoListFooter(expandAllAction: expandSections, collapseAllAction: collapseSections)
            }.navigationDestination(for: Todo.self) { todo in
                TodoListDetailView(todo)
            }
        }
    }
}

#Preview {
    TodoListView()
}
