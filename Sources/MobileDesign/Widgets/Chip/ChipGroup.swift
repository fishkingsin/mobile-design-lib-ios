//
// ChipGroup.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct ChipGroup<Data: Collection, Content: View>: View where Data.Element: Hashable {
    private let theme: NMGThemeable = ThemeManager.shared.currentTheme
    @Binding var index: Int
    let content: ((Int, Data.Element) -> Content)?
    var onTabChanged: (Int, Data.Element) -> Void
    var datas: Data

    public init(
        index: Binding<Int>,
        datas: Data,
        onTabChanged: @escaping (Int, Data.Element) -> Void,
        @ViewBuilder content: @escaping (Int, Data.Element) -> Content
    ) {
        self._index = index
        self.datas = datas
        self.onTabChanged = onTabChanged
        self.content = content
    }

    public var body: some View {

            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(Array(datas.enumerated()), id: \.offset) { index, element in
                        Button(action: {
                            onTabChanged(index, element)
                        }) {
                            content?(index, element)

                        }
                    }
                }.padding([.leading, .trailing], 16).padding(.top, 10)
            }

    }


}

