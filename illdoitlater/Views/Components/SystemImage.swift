//
//  SystemImage.swift
//  im so done
//
//  Created by RB de Guzman on 6/5/25.
//

import SwiftUI

enum SystemIcon: String {
    case chevronDown = "chevron.down"
    case chevronRight = "chevron.right"
}

struct SystemImage: View {
    var icon: SystemIcon
    
    var body: some View {
        Image(systemName: icon.rawValue)
    }
}
