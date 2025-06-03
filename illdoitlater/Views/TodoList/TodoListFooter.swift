//
//  TodoListFooter.swift
//  im so done
//
//  Created by RB de Guzman on 5/7/25.
//

import SwiftUI

fileprivate extension Strings {
    static let collapseAll = "Collapse all"
    static let expandAll = "Expand all"
}

struct TodoListFooter: View {
    @State private var isPresentingNewTodoView: Bool = false
    var onExpandAll: () -> Void
    var onCollapseAll: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "line.3.horizontal.decrease").opacity(0) //TODO: This is inefficient
            Spacer()
            Button("New To Do", systemImage: "plus.circle") {
                isPresentingNewTodoView.toggle()
            }.sheet(isPresented: $isPresentingNewTodoView) {
                NewTodoView()
            }
            Spacer()
            Menu {
                Section("Show") {
                    Button(Strings.collapseAll) { onCollapseAll() }
                    Button(Strings.expandAll) { onExpandAll() }
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
            }.menuOrder(.fixed)
        }.padding([.leading, .trailing, .bottom])
        
    }
}
