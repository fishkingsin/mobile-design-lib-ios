//
// ChipGroupDemo.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import SwiftUI


public struct ChipGroupDemo: View {
    public let theme: NMGThemeable = ThemeManager.shared.currentTheme
    @State public var index: Int = 0

    public var data: [String] {
        stride(from: 1, to: 10, by: 1).map {
            "Title \($0)"
        }
    }

    public init(index: Int) {
        self.index = index
    }

    public var body: some View {
        ChipGroup(index: $index, datas: data) { index, element in
            self.index = index
        } content: { i, element in
            Chip(element: element, index: self.$index, selfIndex: i)
        }
    }
}



struct ChipGroup_Previews: PreviewProvider {
    static var previews: some View {
        ChipGroupDemo(index: 0)
    }
}

