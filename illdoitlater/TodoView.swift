//
//  TodoView.swift
//  illdoitlater
//
//  Created by RB de Guzman on 12/27/24.
//

import SwiftUI

private let PLACEHOLDER_TEXT = "What do you want to do later?"

struct TodoView: View {
    @State private var todoText: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            TextField(PLACEHOLDER_TEXT, text: $todoText, axis: .vertical).font(.title).submitLabel(.next).onChange(of: todoText) {
                _, newValue in
                submitNewLine(value: newValue)
            }
            Spacer()
            Spacer()
        }.padding()
    }
    
    /// Determines the next course of action for a todo item; also clears todoText
    private func onSubmit() {
        todoText = "This is submitted"
        
        //TODO: Add to list
    }
    
    /// Calls onSubmit() if the user enters a newline
    ///
    /// - Parameters:
    ///   - newValue: The value to check against when running submit
    ///
    /// - Returns: A discardable bool that determines if onSubmit() was called (true) or not (false)
    @discardableResult private func submitNewLine(value: String) -> Bool {
        guard value.last == "\n" else {
            return false
        }
        
        todoText.removeLast()
        onSubmit()
        return true
    }
}

#Preview {
    TodoView()
}
