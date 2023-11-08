//
//  SwiftUIView.swift
//  MobileDesignSampleApp
//
//  Created by James Kong on 21/9/2023.
//

import SwiftUI
import MobileDesign
import WebKit
import YouTubeiOSPlayerHelper
import AVKit
struct ReelsPOC: View {

    var reels = [
        MediaFile(url: "Reel-1", title: "@經一速遞", content: "飲飲食食的小生意，對於疊水的投資者，缺乏性感的想像空間。"),
        MediaFile(url: "Reel-2", title: "@經一速遞", content: "若從每人身上賺1元大餅，已是14個億的大茶飯，難度在於中間化零為整的手段。滴灌通主席李小加就想到了破解方案，兼開發出複利生財的投資模式，有如太極生兩儀、兩儀生四象。薑是老的辣，61歲的他下海創業，把生意經的算盤敲得響噹噹。"),
        MediaFile(url: "Reel-3", title: "@經一速遞", content: "")
    ].map { medialFile -> Reel<MediaFile> in
        let path = Bundle.main.path(forResource: medialFile.url, ofType: "mp4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        return Reel<MediaFile>(player: player, mediaFile: medialFile)
    }

    public var body: some View {

        ReelsPager(currentReelID: reels.first!.id, reels: reels)
    }
}


struct ReelsOC_Previews: PreviewProvider {
    static var previews: some View {
        ReelsPOC()
    }
}
