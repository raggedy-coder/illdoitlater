//
//  TodayView.swift
//  im so done
//
//  Created by RB de Guzman on 6/4/25.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Todo.dueDate) private var todos: [Todo]
    @State private var expandedSections: Set<TodayCategory> = Set([.today, .tomorrow, .upcoming, .eventually])
    
    private func collapseAll() {
        expandedSections.removeAll()
    }

    private func expandAll() {
        expandedSections = Set(TodayCategory.allCases)
    }
    
    private func toggleSection(_ category: TodayCategory) {
        if expandedSections.contains(category) {
            expandedSections.remove(category)
        } else {
            expandedSections.insert(category)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                VStack { //Header
                    Text(Strings.currentWeekday).font(.title2)
                    Text(Strings.currentMonthAndDay)
                }.padding()
                List { //Body
                    ForEach(TodayCategory.allCases) { category in
                        let filteredTodos = todos.filterBy(category: category)
                        Section {
                            if expandedSections.contains(category) {
                                ForEach(filteredTodos) { todo in
                                    NavigationLink(value: todo) {
                                        TodoRow(todo)
                                    }
                                }.onDelete { indexes in
                                    for index in indexes {
                                        context.delete(filteredTodos[index])
                                    }
                                    
                                    if context.hasChanges {
                                        try? context.save()
                                    }
                                }
                            } else {
                                EmptyView()
                            }
                        } header: {
                            let config = TodaySectionHeaderConfig(text: category.id.uppercased() + (filteredTodos.count > 0 && category != .completed ? " (\(filteredTodos.count))" : ""), color: category.color, isExpanded: expandedSections.contains(category), onClearAll: (category == .pastDue && filteredTodos.count > 0) ? {
                                filteredTodos.forEach { context.delete($0) }
                                if context.hasChanges {
                                    try? context.save()
                                }
                            } : nil, onTapExpand: {
                                toggleSection(category)
                            })
                            TodaySectionHeader(config: config )
                        }.listRowSeparator(.hidden)
                    }
                }
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                TodayFooter(onExpandAll: expandAll, onCollapseAll: collapseAll)
            }.navigationDestination(for: Todo.self) { todo in
                EditTodoView(todo)
            }
        }
    }
}

fileprivate enum TodayCategory: String, CaseIterable, Identifiable {
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

fileprivate extension Array where Element == Todo {
    func filterBy(category: TodayCategory) -> [Todo] {
        switch category {
        case .pastDue: return notCompleted.pastDue
        case .today: return notCompleted.today
        case .tomorrow: return notCompleted.tomorrow
        case .upcoming: return notCompleted.upcoming
        case .eventually: return notCompleted.noDueDates
        case .completed: return completed
        }
    }
}

#Preview {
    TodayView()
}
