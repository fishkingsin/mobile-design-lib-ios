//
// MenuItem.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import SwiftUI

struct MenuItem<Content: View>: Identifiable {
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        lhs.id == rhs.id
    }

    let id = UUID()

    var name: String

    @ViewBuilder let content: Content
}
