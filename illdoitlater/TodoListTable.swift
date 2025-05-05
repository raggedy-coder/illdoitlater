//
//  TodoListTable.swift
//  illdoitlater
//
//  Created by RB de Guzman on 5/4/25.
//
import SwiftUI
import SwiftData

fileprivate enum TodoListTableCategories: String, CaseIterable, Identifiable {
    case pastDue = "Past Due"
    case today = "Today"
    case tomorrow = "Tomorrow"
    case upcoming = "Upcoming"
    case eventually = "Eventually"
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .pastDue: return .red
        case .today: return .blue
        case .tomorrow: return .orange
        case .upcoming: return .green
        case .eventually: return .gray
        }
    }
    
    func filtered(_ todos: [Todo]) -> [Todo] {
        switch self {
        case .pastDue: return todos.pastDue
        case .today: return todos.today
        case .tomorrow: return todos.tomorrow
        case .upcoming: return todos.upcoming
        case .eventually: return todos.noDueDates
        }
    }
    
}
struct TodoListTable: View {
    @Environment(\.modelContext) private var context
    var todos: [Todo]
    
    init(_ todos: [Todo]) {
        self.todos = todos
    }
    
    private func removeTodos(at indexes: IndexSet) {
        for index in indexes {
            context.delete(todos[index])
        }
        
        if context.hasChanges {
            try? context.save()
        }
    }
    
    var body: some View {
        List {
            ForEach(TodoListTableCategories.allCases) { category in
                let filteredTodos = category.filtered(todos)
                
                if filteredTodos.isEmpty {
                    EmptyView()
                } else {
                    Section(header: Text(category.id).foregroundStyle(category.color), content: {
                        ForEach(filteredTodos) { todo in
                            NavigationLink {
                                TodoListDetailView(todo)
                            } label: {
                                TodoListRow(todo)
                            }
                        }.onDelete { indexes in
                            removeTodos(at: indexes)
                        }
                    })
                }
            }.listRowSeparator(.hidden)
        }.listStyle(.plain)
    }
}
