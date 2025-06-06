//
//  TodaySectionHeader.swift
//  im so done
//
//  Created by RB de Guzman on 6/4/25.
//

import SwiftUI

fileprivate extension Strings {
    static let clearAll = "Clear All"
    static let clearAllConfirmation = "Delete all past due todos?"
}

struct TodaySectionHeaderConfig {
    var text: String
    var color: Color
    var isExpanded: Bool = true
    var onClearAll: (() -> Void)?
    var onTapExpand: (() -> Void)?
}

struct TodaySectionHeader: View {
    var config: TodaySectionHeaderConfig
    @State private var isPresentingClearAllAlert: Bool = false

    var body: some View {
        Button {
            config.onTapExpand?()
        } label: {
            HStack(alignment: .center) {
                SystemImage(icon: config.isExpanded ? .chevronDown : .chevronRight)
                Text(config.text)
                Spacer()
                if let onClearAll = config.onClearAll {
                    Button(Strings.clearAll) {
                        isPresentingClearAllAlert.toggle()
                    }
                    .padding([.vertical], 4)
                    .padding([.horizontal], 8)
                    .background(config.color)
                    .foregroundStyle(.white)
                    .cornerRadius(8).clipped()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(config.color, lineWidth: 1)
                    )
                    .alert(Strings.clearAllConfirmation, isPresented: $isPresentingClearAllAlert) {
                        Button(Strings.cancel, role: .cancel) {}
                        Button(Strings.confirm, role: .destructive) {
                            onClearAll()
                        }
                    }
                }
            }
        }
        .font(.caption)
        .foregroundStyle(config.color)
        .textCase(nil)
    }
}
