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

    var reels = ["Reel-1", "Reel-2", "Reel-3"].map { medialFile -> Reel<MediaFile> in
        let path = Bundle.main.path(forResource: medialFile, ofType: "mp4") ?? ""
        let player = AVPlayer()
        return Reel<MediaFile>(player: player, mediaFile: MediaFile(url: medialFile, title: "", isExpanded: false))
    }
    public var body: some View {

        ReelsPager(currentReel: reels.first!.id, reels: reels)
    }
}

struct ReelsOC_Previews: PreviewProvider {
    static var previews: some View {
        ReelsPOC()
    }
}
