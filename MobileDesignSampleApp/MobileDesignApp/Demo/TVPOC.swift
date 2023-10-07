//
//  SwiftUIView.swift
//  MobileDesignSampleApp
//
//  Created by James Kong on 21/9/2023.
//

import SwiftUI
import MobileDesign
import WebKit
import M3U8Parser


class TVPOCViewModel: ObservableObject {
    var url: NSURL
    init(url: NSURL) {
        self.url = url
    }

    func load() {
        url.m3u_loadAsyncCompletion { model, error in
            print("mode \(model) error \(error)")
        }
    }

}
struct TVPOC<ContentView>: View where ContentView: View {
    @ObservedObject var viewModel: TVPOCViewModel
    var url: String

    var content: (String) -> ContentView

    init(url: String, content: @escaping (String) -> ContentView) {
        viewModel = TVPOCViewModel(url: NSURL(string: url)!)
        self.url = url
        self.content = content
    }

    var body: some View {
        GeometryReader { proxy in
            VStack {
                content(url).frame(maxHeight: (proxy.size.width / 16) * 9)
                    .onAppear{
                        viewModel.load()
                    }
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        Text("獨家專訪｜用科技顛覆金融 李小加革新小店投資模式 #1")
                            .font(
                                Font.custom("Noto Sans TC", size: 20)
                                    .weight(.medium)
                            )
                            .kerning(0.5)
                            .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(.horizontal, 16)
                    .frame(alignment: .topLeading)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("2022/11/25")
                            .font(Font.custom("PingFang HK", size: 12))
                            .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                        Text("飲飲食食的小生意，對於疊水的投資者，缺乏性感的想像空間，偏偏神州大地是14億人口的市場，若從每... 展開")
                            .font(Font.custom("Noto Sans TC", size: 14))
                            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                            .frame(alignment: .leading)
                        HStack(alignment: .center) {
                            // Space Between
                            Image("like")
                                .frame(width: 20, height: 17.10343)
                            // Alternative Views and Spacers
                            Image("share")
                                .frame(width: 20, height: 20.5)
                        }
                        .padding(0)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(alignment: .center, spacing: 0) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("李小加獨家專訪 2小時足本回顧")
                                        .font(
                                            Font.custom("PingFang HK", size: 16)
                                                .weight(.medium)
                                        )
                                        .kerning(0.4)
                                        .foregroundColor(Color(red: 0.12, green: 0.22, blue: 0.65))
                                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                    Text("滴灌通主席李小加就想到了破解方案，兼開發出複利生財的投資模式，有如太極生兩儀、兩儀生四象。薑是老的辣，61歲的他下海創業，把生意經的算盤敲得更為響噹噹。")
                                        .font(Font.custom("Noto Sans TC", size: 14))
                                        .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                                        .frame(maxWidth: .infinity, minHeight: 39, maxHeight: 39, alignment: .topLeading)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                HStack(alignment: .top, spacing: 10) {
                                    Image("arrow")
                                        .frame(width: 32, height: 32)
                                }
                            }
                            .padding(0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white.opacity(0.95))
                            .background(Color(red: 0, green: 0.89, blue: 1))
                            .cornerRadius(4)

                            .padding(.leading, 0)
                            .padding(.trailing, 12)
                            .padding(.vertical, 22)
                            .frame(maxHeight: .infinity, alignment: .topLeading)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 0)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 0)
                    .background(.white)
                }
            }
        }
    }
}

struct TVPOC_Previews: PreviewProvider {
    static var previews: some View {
        TVPOC(url: "NEpgCftIYmQ") { url in
            YoutubePlayerView(isAutoplay: true) {
                $0.load(withVideoId: url)
            }
        }
    }
}
