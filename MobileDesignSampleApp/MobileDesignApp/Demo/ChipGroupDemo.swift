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

    var data: [ChipDataDemo] { [
        ChipDataDemo("Title 10", ""), ChipDataDemo("Title 100", "https://placehold.co/24x24/png"), ChipDataDemo("Title 1000", "https://placehold.co/24x24/png")]
    }

    init(index: Int) {
        self.index = index
    }

    var body: some View {
        ChipGroup(datas: data, index: index) { index, _ in
            self.index = index
            debugPrint("index \(index)")
        }
    }
}

struct ChipGroup_Previews: PreviewProvider {
    static var previews: some View {
        ChipGroupDemo(index: 0)
    }
}
