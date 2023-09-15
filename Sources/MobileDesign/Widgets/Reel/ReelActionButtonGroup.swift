//
// ReelActionButtonGroup.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

struct ReelActionButtonGroup: View {

    var body: some View {
        VStack(spacing: 15) {

            Button {

            } label: {
                VStack(spacing: 6) {
                    Image("deeplink", bundle: Bundle.module)
                        .font(.title)
                }.frame(width: 36, height: 36)
            }
            Button {

            } label: {
                VStack(spacing: 6) {
                    LikeAnimationView().frame(width: 36, height: 36)
                }
            }
            Button {

            } label: {
                VStack(spacing: 6) {
                    Image("Share", bundle: Bundle.module)
                        .font(.title).frame(width: 36, height: 36)
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
