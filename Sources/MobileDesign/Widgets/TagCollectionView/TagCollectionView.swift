//
// TagCollectionView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct TagCollectionView: View {

    let tags: [String]

    private let theme: NMGThemeable

    public init(tags: [String], theme: NMGThemeable = ThemeManager.shared.currentTheme) {
        self.tags = tags
        self.theme = theme
    }

    public var body: some View {
        FlexibleView(data: tags, alignment: .leading, inLineSpacing: 4, spacing: 8) { value in
            TagView(
                value: value,
                action: { _ in
                
            })
                .background(Color(theme.colors.primaryMain))
                .clipShape(Capsule())
        }
    }
}

struct TagCollectionView_Preview: PreviewProvider {
    static var previews: some View {
        TagCollectionView(tags: (Int(0)...Int(5)).map {
            return "Tag \($0)"
        })
        .frame(height: .infinity, alignment: .topLeading)
            .clipped()
            .background(Color.red)
    }
}
