//
//  TodoListTable.swift
//  illdoitlater
//
//  Created by RB de Guzman on 5/4/25.
//

import SwiftUI

//TODO: Refactor this
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
    @State var isPresentingClearAllAlert: Bool = false
    
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
    
    private func removeFilteredTodos(_ todos: [Todo]) {
        todos.forEach { todo in context.delete(todo) }
        
        if context.hasChanges {
            try? context.save()
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
    
    private func SectionHeader(for todos: [Todo], in category: TodoListTableCategory) -> some View {
        let sectionText = "\(category.rawValue.uppercased())\(todos.count > 0 && category != .completed ? " (\(todos.count))" : "")"
        
        return Button {
            toggleSection(category)
        } label: {
            HStack(alignment: .center) {
                Image(systemName: expandedCategories.contains(category) ? "chevron.down" : "chevron.right")
                Text(sectionText)
                Spacer()
                if category == .pastDue {
                    Button("Clear all") {
                        isPresentingClearAllAlert = true
                    }
//                    .labelStyle(.iconOnly)
                    .padding([.vertical], 4)
                    .padding([.horizontal], 8)
                    .background(category.color)
                    .foregroundStyle(.white)
                    .cornerRadius(8).clipped()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(category.color, lineWidth: 1)
                    )
                    .alert("Are you sure you want to delete \(todos.count) todo\(todos.count > 1 ? "s" : "")?", isPresented: $isPresentingClearAllAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Confirm", role: .destructive) {
                            removeFilteredTodos(todos)
                        }
                    }
                }
            }
        }
        .font(.caption)
        .foregroundStyle(category.color)
        .textCase(nil)
    }
    
    var body: some View {
        List {
            ForEach(TodoListTableCategory.allCases) { category in
                let filteredTodos = filtered(by: category)
                if filteredTodos.isEmpty {
                    EmptyView()
                } else {
                    Section {
                        if expandedCategories.contains(category) {
                            ForEach(filteredTodos) { todo in
                                NavigationLink(value: todo) {
                                    TodoListRow(todo)
                                }
                            }.onDelete { indexes in
                                removeTodos(at: indexes)
                            }
                        }
                    } header: {
                        SectionHeader(for: filteredTodos, in: category)
                    }
                }
            }.listRowSeparator(.hidden)
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
    }
}
