//
//  TodoForm.swift
//  im so done
//
//  Created by RB de Guzman on 6/1/25.
//

import SwiftUI

struct TodoForm: View {
    @State var text: String = ""
    @State var dueDateOption: DueDateOption = .none
    @State var dueDate: Date = Date()
    
    var onSubmit: ((String, DueDateOption, Date) -> Void)?
    var onChange: ((String) -> Void)?

    var body: some View {
        VStack() {
            TextField(Strings.newTodoPlaceholder, text: $text)
                .font(.title)
                .submitLabel(.done)
                .onSubmit {
                    onSubmit?(text, dueDateOption, dueDate)
                }.onChange(of: text) { _, newValue in
                    onChange?(newValue)
                }
            DueDatePicker(dueDateOption: $dueDateOption, dueDate: $dueDate)
        }
    }
}

#Preview {
    TodoForm()
}
