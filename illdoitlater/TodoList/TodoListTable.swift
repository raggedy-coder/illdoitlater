//
//  TodoListTable.swift
//  illdoitlater
//
//  Created by RB de Guzman on 5/4/25.
//

import SwiftUI
import SwiftData

enum TodoListTableCategory: String, CaseIterable, Identifiable {
    case pastDue = "Past Due"
    case today = "Today"
    case tomorrow = "Tomorrow"
    case upcoming = "Upcoming"
    case eventually = "Eventually"
    case completed = "Completed"
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .pastDue: return .red
        case .today: return .blue
        case .tomorrow: return .orange
        case .upcoming: return .green
        case .eventually: return .yellow
        case .completed: return .gray
        }
    }
}

struct TodoListTable: View {
    @Environment(\.modelContext) private var context
    @Binding var expandedCategories: Set<TodoListTableCategory>
    
    var todos: [Todo]
    
    init(_ todos: [Todo], expandedCategories: Binding<Set<TodoListTableCategory>>) {
        self.todos = todos
        self._expandedCategories = expandedCategories
    }
    
    private func filtered(by category: TodoListTableCategory) -> [Todo] {
        switch category {
        case .pastDue: return todos.notCompleted.pastDue
        case .today: return todos.notCompleted.today
        case .tomorrow: return todos.notCompleted.tomorrow
        case .upcoming: return todos.notCompleted.upcoming
        case .eventually: return todos.notCompleted.noDueDates
        case .completed: return todos.completed
        }
    }
    
    private func removeTodos(at indexes: IndexSet) {
        for index in indexes {
            context.delete(todos[index])
        }
        
        if context.hasChanges {
            try? context.save()
        }
    }
    
    private func toggleSection(_ category: TodoListTableCategory) {
        if expandedCategories.contains(category) {
            expandedCategories.remove(category)
        } else {
            expandedCategories.insert(category)
        }
    }
    
    var body: some View {
        List {
            ForEach(TodoListTableCategory.allCases) { category in
                let filteredTodos = filtered(by: category)
                let isExpanded = expandedCategories.contains(category)
                
                if filteredTodos.isEmpty {
                    EmptyView()
                } else {
                    Section {
                        if isExpanded {
                            ForEach(filteredTodos) { todo in
                                NavigationLink(value: todo) {
                                    TodoListRow(todo)
                                }
                            }.onDelete { indexes in
                                removeTodos(at: indexes)
                            }
                        } else {
                            EmptyView()
                        }
                    } header: {
                        Button {
                            toggleSection(category)
                        } label: {
                            HStack {
                                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                                Text(category.rawValue)
                                    .font(.caption)
                                Spacer()
                            }.foregroundStyle(category.color)
                        }
                    }
                }
            }.listRowSeparator(.hidden)
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
    }
}
