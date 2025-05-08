//
//  NewTodoView.swift
//  illdoitlater
//
//  Created by RB de Guzman on 12/27/24.
//

import SwiftUI

//TODO: Extract and place in a constants file
private let PLACEHOLDER_TEXT = "What do you need to do?"

//TODO: Extract and replace with themes
fileprivate extension View {
    func formattedPicker() -> some View {
        tint(.green).foregroundStyle(.gray)
    }
}

fileprivate enum DueDateOption: String, CaseIterable, Identifiable {
    case none, today, tomorrow, nextWeek, pickDate
    var id: Self { self }
    
    var text: String {
        switch self {
        case .none: return "None"
        case .today: return "Today"
        case .tomorrow: return "Tomorrow"
        case .nextWeek : return "Next Week"
        case .pickDate: return "Pick Date"
        }
    }
    
    var date: Date? {
        switch self {
        case .none: return nil
        case .today: return Date.today
        case .tomorrow: return Date.tomorrow
        case .nextWeek: return Date.nextWeek
        case .pickDate: return nil
        }
    }
}

struct NewTodoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    @State fileprivate var dueDateOption: DueDateOption = .none
    @State private var dueDate: Date = Date()
    @State private var text: String = ""
    @State private var showingAlert: Bool = false
    
    private func save() {
        context.insert(Todo(text: text, dueDate: dueDateOption == .pickDate ? dueDate : dueDateOption.date))
        
        if context.hasChanges {
            try? context.save()
        }
        
        dismiss()
    }
    
    private func NewTodoFooter() -> some View {
        return HStack(alignment: .center) {
            Spacer()
            Button("Cancel") {
                if text.isEmpty {
                    dismiss()
                } else {
                    showingAlert = true
                }
            }.alert(Text("Exit without saving?"), isPresented: $showingAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Exit", role: .destructive) {
                    dismiss()
                }
            }
            Spacer()
//            Button("Save") {
//                save()
//            }
//            Spacer()
        }
    }
    
    var body: some View {
        VStack() {
            Spacer()
            TextField(PLACEHOLDER_TEXT, text: $text)
                .font(.title)
                .submitLabel(.done)
                .onSubmit {
                    save()
                }
            HStack(alignment: .center, content: {
                Spacer()
                Text("Due date")
                Picker("", selection: $dueDateOption) {
                    ForEach (DueDateOption.allCases) {
                        Text($0.text).tag($0)
                    }
                }
            }).formattedPicker()
            if dueDateOption == .pickDate {
                HStack(alignment: .center, content: {
                    Spacer()
                    DatePicker("", selection: $dueDate, displayedComponents: [.date])
                }).formattedPicker()
            }
            Spacer()
            NewTodoFooter()
        }.padding()
    }
}

#Preview {
    NewTodoView()
}
