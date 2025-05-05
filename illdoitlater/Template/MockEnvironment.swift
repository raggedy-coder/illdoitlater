//
//  MockEnvironment.swift
//  illdoitlater
//
//  Created by RB de Guzman on 4/22/25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var mockString: String = "mockString"
}

extension View {
    func sample() -> some View {
        return environment(\.mockString, "newValue")
    }
}
