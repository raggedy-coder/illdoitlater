//
//  TodoListFooter.swift
//  im so done
//
//  Created by RB de Guzman on 5/7/25.
//

import SwiftUI

struct TodoListFooter: View {
    @State private var showingNewTodoView: Bool = false
    var expandAllAction: () -> Void
    var collapseAllAction: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "line.3.horizontal.decrease").opacity(0) //TODO: This is inefficient
            Spacer()
            Button("New To Do", systemImage: "plus.circle") {
                showingNewTodoView.toggle()
            }.sheet(isPresented: $showingNewTodoView) {
                NewTodoView()
            }
            Spacer()
            Menu {
                Section("Show") {
                    Button("Collapse all") { collapseAllAction() }
                    Button("Expand all") { expandAllAction() }
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
            }.menuOrder(.fixed)
        }.padding([.leading, .trailing, .bottom])
        
    }
}
