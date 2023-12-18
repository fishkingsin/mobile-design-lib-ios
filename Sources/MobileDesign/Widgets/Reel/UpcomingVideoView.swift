//
//  File.swift
//
//
//  Created by Joey Sun on 2023/10/17.
//

import Foundation
import SwiftUI
import Kingfisher

protocol UpcomingItem {
    var imageURL: String { get }
    var headline: String { get }
    var secCountDown: Int { get }
}

protocol UpcomingVideoViewEvent {
    func onClickCancel()
    func onClickPlay()
}

struct UpcomingVideoView<Item: UpcomingItem>: View {
    var item: Item
    var event: UpcomingVideoViewEvent?
    
    @State private var secCountDown = 10
    private let theme: NMGThemeable = ThemeManager.shared.currentTheme
    
    var body: some View {
        VStack() {
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
            HStack() {
                Spacer().frame(width: 14)
                ZStack(alignment: .bottomTrailing) {
                    KFImage.url(URL(string: item.imageURL))
                        .resizable()
                        .frame(width: 144, height: 75)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                Text(item.headline)
                    .font(.system(size: 16))
                    .foregroundColor(theme.colors.neutralGray2.color)
                    .lineLimit(3)
                    .truncationMode(.tail)
                Spacer().frame(width: 14)
            }
            Spacer()
            HStack() {
                Spacer().frame(width: 16)
                Button(action: {
                    event?.onClickCancel()
                }){
                    Text("取消")
                        .font(.system(size: 16))
                        .foregroundColor(theme.colors.neutralGray2.color)
                        .frame(maxWidth: .infinity)
                        .padding(9)
                        .background(RoundedRectangle(cornerRadius: 2).stroke(theme.colors.neutralGray2.color))
                }
                Spacer().frame(width: 16)
                Button(action: {
                    event?.onClickPlay()
                }){
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
        }.background(Color.black)
    }
}

struct UpcomingVideoView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingVideoView(item: MockUpcomingItem(), event: nil)
    }
}

struct MockUpcomingItem: UpcomingItem {
    var secCountDown: Int = 10
    var imageURL: String = ""
    var headline: String = "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式"
}
