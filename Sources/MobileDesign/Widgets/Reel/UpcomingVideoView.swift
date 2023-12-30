//
//  File.swift
//
//
//  Created by Joey Sun on 2023/10/17.
//

import Foundation
import SwiftUI
import Kingfisher
import Combine

public struct UpcomingVideoView<Data>: View where Data: VideoDisplayable {
    var item: Data

    @State private var secCountDown = 10
    @State private var timer: AnyCancellable?

    var onCancelTap: () -> Void
    var nextVideoAction: () -> Void
    private let theme: NMGThemeable = ThemeManager.shared.currentTheme

    public init(item: Data, onCancelTap: @escaping () -> Void, nextVideoAction: @escaping () -> Void) {
        self.item = item
        self.onCancelTap = onCancelTap
        self.nextVideoAction = nextVideoAction
    }

    public var body: some View {
        VStack {
            Spacer().frame(height: 11)
            HStack {
                Spacer().frame(width: 18)
                Text("將於")
                    .font(.system(size: 14))
                    .foregroundColor(theme.colors.neutralGray50.color)
                Text("\(secCountDown)")
                    .font(.system(size: 14))
                    .foregroundColor(theme.colors.neutralGray2.color)
                Text("秒後播放")
                    .font(.system(size: 14))
                    .foregroundColor(theme.colors.neutralGray50.color)
                Spacer()
            }
            HStack {
                Spacer().frame(width: 14)
                if let url = item.imageURL {
                    ZStack(alignment: .bottomTrailing) {
                        KFImage.url(URL(string: url))
                            .resizable()
                            .scaledToFit()
                            .frame(height: 75)
                            .background(Color.white)
                            .aspectRatio( 16 / 9 , contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
                if let headline = item.headline {
                    Text(headline)
                        .font(.system(size: 16))
                        .foregroundColor(theme.colors.neutralGray2.color)
                        .lineLimit(3)
                        .truncationMode(.tail)
                }
                Spacer().frame(width: 14)
            }
            Spacer()
            HStack {
                Spacer().frame(width: 16)
                Button(action: {
                    self.timer?.cancel()
                    onCancelTap()
                }) {
                    Text("取消")
                        .font(.system(size: 16))
                        .foregroundColor(theme.colors.neutralGray2.color)
                        .frame(maxWidth: .infinity)
                        .padding(9)
                        .background(RoundedRectangle(cornerRadius: 2).stroke(theme.colors.neutralGray2.color))
                }
                Spacer().frame(width: 16)
                Button(action: {
                    nextVideoAction()
                    self.timer?.cancel()
                }) {
                    Text("立即播放")
                        .font(.system(size: 16))
                        .foregroundColor(theme.colors.neutralGray90.color)
                        .frame(maxWidth: .infinity)
                        .padding(9)
                        .background(theme.colors.neutralGray2.color)
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                }
                Spacer().frame(width: 16)
            }
            Spacer().frame(height: 11)
        }
        .background(Color.black)
        .onAppear { startCountdown() }
        .onDisappear { timer?.cancel() }
    }

    private func startCountdown() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { _ in
                if self.secCountDown > 0 {
                    self.secCountDown -= 1
                } else {
                    self.timer?.cancel()
                    nextVideoAction()
                }
            }
    }
}

 struct UpcomingVideoView_Previews: PreviewProvider {
    @State static var isFinish: Bool = false

    static var previews: some View {
        UpcomingVideoView(item: MockUpcomingItem(), onCancelTap: {
            print("cancel")
        }, nextVideoAction: {
            print("play")
        })
    }
 }

struct MockUpcomingItem: VideoDisplayable {
    var imageURL: String? = "https://placehold.co/600x400/png?text=hello%5cnworld"

    var headline: String? = "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式"

    var leadingFootnote: String? = "footnote"

    var secondFootnote: String? = "footnote"

    var id: Int?
    
    var url: String?
    
    var videoType: String?


 }
