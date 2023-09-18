//
// ReelActionButtonGroup.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

struct ReelActionButton: View{
    var imageName: String
    var content: String?
    var additionData: String?
    var onClick :() -> Void
    
    init(imageName: String, content: String?, onClick: @escaping () -> Void) {
        self.imageName = imageName
        self.content = content
        self.onClick = onClick
    }
    
    var body: some View {
        Button {
            onClick()
        } label: {
            VStack(spacing: 10) {
                Image(systemName: imageName)
                    .font(.title)
                if let aContent = content {
                    Text(aContent).font(.caption.bold())
                }
            }
        }
    }
}

struct ReelActionButtonGroup: View {
//    var reelActionBtnList:[ReelActionButton]
    
    
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
/*
            Button {
            } label: {
                VStack(spacing: 10) {
                    Image("menu")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .rotationEffect(Angle(degrees: 90))
                }
            }
 */
        }
    }
}

struct ReelActionButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        ReelActionButtonGroup()
    }
}
