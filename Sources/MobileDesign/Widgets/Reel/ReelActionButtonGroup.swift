//
// ReelActionButtonGroup.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

struct ReelActionButtonGroup: View {

    var body: some View {
        VStack(spacing: 25) {

            Button {

            } label: {
                VStack(spacing: 10) {
                    LikeAnimationView().frame(width: 30, height: 20)
                }
            }
            Text("100k")
                .font(.caption.bold())

            Button {

            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "bubble.right")
                        .font(.title)

                    Text("120")
                        .font(.caption.bold())

                }
            }

            Button {

            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "paperplane")
                        .font(.title)
                }
            }

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
        }
    }
}

struct ReelActionButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        ReelActionButtonGroup()
    }
}
