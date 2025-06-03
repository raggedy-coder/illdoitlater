//
//  DueDatePicker.swift
//  im so done
//
//  Created by RB de Guzman on 6/1/25.
//

import SwiftUI

fileprivate extension Strings {
    static let dueDate = "Due Date"
}

struct DueDatePicker: View {
    @Binding var dueDateOption: DueDateOption
    @Binding var dueDate: Date
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Text(Strings.dueDate)
                Picker("", selection: $dueDateOption) {
                    ForEach(DueDateOption.allCases) {
                        Text($0.text).tag($0)
                    }
                }
            }
            if dueDateOption == .pickDate {
                HStack(alignment: .center) {
                    Spacer()
                    DatePicker("", selection: $dueDate, displayedComponents: [.date])
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var dueDateOption: DueDateOption = .none
    @Previewable @State var dueDate: Date = Date()
    DueDatePicker(dueDateOption: $dueDateOption, dueDate: $dueDate)
}
