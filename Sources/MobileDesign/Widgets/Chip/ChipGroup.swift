//
// ChipGroup.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

struct ChipGroupInternal<Data: Collection, Content: View>: View where Data.Element: ChipData {
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
                HStack {
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

public protocol ChipData: Identifiable, Hashable {
    var id: String { get }
    var title: String { get }
}

public struct ChipGroup<Data>: View where Data: ChipData {

    var datas: [Data]
    @State public var index: Int = 0
    var onTabChanged: (Int, Data) -> Void

    public init(datas: [Data], index: Int, onTabChanged: @escaping (Int, Data) -> Void) {
        self.datas = datas
        self.index = index
        self.onTabChanged = onTabChanged
    }

    public var body: some View {
        ChipGroupInternal(index: $index, datas: datas) { index, data in
            self.index = index
            onTabChanged(index, data)
        } content: { i, element in
            Chip(element: element, index: self.$index, selfIndex: i)
        }
    }
}
