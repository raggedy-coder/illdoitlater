//
//  NewTodoView.swift
//  illdoitlater
//
//  Created by RB de Guzman on 12/27/24.
//

import SwiftUI

struct NewTodoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    @State private var showsAlert: Bool = false
    @State private var hasChanges: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            TodoForm(onSubmit:  { text, dueDateOption, date
                in
                let todo = Todo(text: text, dueDate: dueDateOption == .pickDate ? date : dueDateOption.correspondingDate)
                context.insert(todo)
                
                if context.hasChanges {
                    try? context.save()
                }
                
                dismiss()
            }, onChange: { newText in
                hasChanges = !newText.isEmpty
            })
            Spacer()
            NewTodoFooter()
        }.padding()
    }
    
    private func NewTodoFooter() -> some View {
        HStack(alignment: .center) {
            Spacer()
            Button("Cancel") {
                if !hasChanges {
                    dismiss()
                } else {
                    showsAlert = true
                }
            }.alert(Text("Exit without saving?"), isPresented: $showsAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Exit", role: .destructive) {
                    dismiss()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    NewTodoView()
}
