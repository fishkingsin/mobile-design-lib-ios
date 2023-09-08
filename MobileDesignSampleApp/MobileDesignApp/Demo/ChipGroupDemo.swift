//
// ChipGroupDemo.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import SwiftUI
import MobileDesign

struct ChipGroupDemo: View {
    let theme: NMGThemeable = ThemeManager.shared.currentTheme
    @State var index: Int = 0

    var data: [ChipDataDemo] {
        stride(from: 1, to: 10, by: 1).map {
            ChipDataDemo("Title \($0)")
        }
    }

    init(index: Int) {
        self.index = index
    }

    var body: some View {
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

