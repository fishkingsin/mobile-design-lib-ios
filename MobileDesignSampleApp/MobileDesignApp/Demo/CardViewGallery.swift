//
// CardViewGallery.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI
import MobileDesign

struct ChipDataDemo: ChipData {
    var id: String = UUID().uuidString

    var title: String
    var iconUrl: String

    init(_ title: String, _ iconUrl: String) {
        self.title = title
        self.iconUrl = iconUrl
    }

}

class CardViewGalleryViewModel: ObservableObject {

    @Published var datas: [CardData] = {
        return stride(from: 0, to: 10, by: 1).map { index in
            CardData(
                imageURL: "https://placehold.co/358x200/png?text=\(index)",
                headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
                leadingFootnote: "4小時前",
                secondFootnote: "經人觀點",
                timecode: "22:22"
            )
        }
    }()

    func populateData(page: Int) {

        datas.append(contentsOf: stride(from: page * 10, to: (page + 1) * 10, by: 1).map { index in
            CardData(
                imageURL: "https://placehold.co/358x200/png?text=\(index)",
                headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
                leadingFootnote: "4小時前",
                secondFootnote: "經人觀點",
                timecode: "22:22"
            )
        })

    }

    func shouldLoadData(id: Int) -> Bool {
        return id == datas.count - 2
    }

}

struct CardViewGallery: View {
    @EnvironmentObject var themeManager: ThemeManager
    var reelDatas: [CardData] = {
        return stride(from: 0, to: 100, by: 1).map { index in
            CardData(
                imageURL: "https://placehold.co/120x224/png?text=\(index)",
                headline: "獨家專訪｜用科技顛覆金融 李小加革新小店投資模式",
                leadingFootnote: "4小時前",
                secondFootnote: "經人觀點",
                timecode: "22:22"
            )
        }
    }()

    @State public var index: Int = 0
    @State public var currentPage: Int = 0

    @StateObject private var viewModel = CardViewGalleryViewModel()
    var body: some View {
        List(viewModel.datas.enumerated().map { $0 }, id: \.element.id) { index, data in
            if index == 0 {
                Section {
                    ChipGroup(datas: [
                        ChipDataDemo("Title 10", ""), ChipDataDemo("Title 100", "https://placehold.co/24x24/png"), ChipDataDemo("Title 1000", "https://placehold.co/24x24/png")], index: 0) { index, _ in
                        self.index = index
                        debugPrint("index \(index)")
                    }
                }
                .listRowSeparator(.hidden)
                Section(header: Text("最新的連續短片")
                    .font(themeManager.currentTheme.fonts.cardTitle.uiFont)
                    .foregroundColor(themeManager.currentTheme.colors.headline.color)
                ) {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Array(reelDatas.enumerated()), id: \.element.id) { index, data in
                                ReelCard(data: data,
                                         viewDidClick: {
                                    debugPrint("click reel \(index)")
                                })
                            }
                        }
                    }
                }
                .listRowSeparator(.hidden)
            }

            VideoCardView(data: data, onTabChanged: {
                // click action
                debugPrint("index \(index)")
            }).onAppear {
                    // When ScrollView arrives at the position `numbers.count - 2`
                    // increment currentPage, and load more data
                    if viewModel.shouldLoadData(id: index) {
                        currentPage += 1
                        viewModel.populateData(page: currentPage)
                    }
                }.listRowSeparator(.hidden)
        }.listStyle(.plain)
    }
}

struct CardViewGallery_Previews: PreviewProvider {
    static var previews: some View {
        CardViewGallery().environmentObject(ThemeManager.shared)
    }
}
