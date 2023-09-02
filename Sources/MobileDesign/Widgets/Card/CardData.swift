//
// CardData.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct CardData: CardDisplayable, TimecodeDisplayable {
    public var timecode: String { _timecode ?? "--:--" }

    public var imageURL: String
    public var headline: String
    public var leadingFootnote: String
    public var secondFootnote: String
    public var _timecode: String?
    public init(imageURL: String, headline: String, leadingFootnote: String, secondFootnote: String, timecode: String? = nil) {
        self.imageURL = imageURL
        self.headline = headline
        self.leadingFootnote = leadingFootnote
        self.secondFootnote = secondFootnote
        self._timecode = timecode
    }
}
