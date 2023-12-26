//
// ReelActionButtonGroup.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

struct ReelActionButtonGroup: View {
    @State var isLiked: Bool? = false
    var body: some View {
        VStack(spacing: 15) {

            Button {

            } label: {
                VStack(spacing: 6) {
                    Image(systemName: "link")
                        .frame(width: 36, height: 36)
                }
            }
            Button {

            } label: {
                VStack(spacing: 6) {
                    LikeAnimationView(buttonTappedCompletion: nil, externalButtonTapped: $isLiked).frame(width: 36, height: 36)
                }
            }
            Button {

            } label: {
                VStack(spacing: 6) {
                    Image(systemName: "square.and.arrow.up")
                        .frame(width: 36, height: 36)
                }
            }
        }
    }
}

struct ReelActionButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        ReelActionButtonGroup()
    }
}
