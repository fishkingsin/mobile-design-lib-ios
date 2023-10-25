//
// ReelActionButtonGroup.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

struct ReelActionButton: View{
    var imageName: String
    var caption: String?
    var onClick :() -> Void
    
    init(imageName: String, content: String?, onClick: @escaping () -> Void) {
        self.imageName = imageName
        self.caption = content
        self.onClick = onClick
    }
    
    var body: some View {
        Button {
            onClick()
        } label: {
            VStack(spacing: 10) {
                Image(systemName: imageName)
                    .font(.title)
                if let aContent = caption {
                    Text(aContent).font(.caption.bold())
                }
            }
        }
    }
}

struct ReelActionButtonGroup: View {
    var body: some View {
        VStack(spacing: 25) {
            ReelActionButton(imageName: "link", content: "120", onClick: {
                debugPrint("click bubble")
            })
            ReelActionButton(imageName: "suit.heart", content: "100k", onClick: {
                debugPrint("click heart")
            })
            ReelActionButton(imageName: "square.and.arrow.up", content: nil, onClick: {
                debugPrint("click paperplane")
            })
        }
    }
}

struct ReelActionButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        ReelActionButtonGroup()
    }
}
