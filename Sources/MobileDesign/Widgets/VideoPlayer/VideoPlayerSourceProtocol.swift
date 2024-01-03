//
//  VideoPlayerSourceProtocol.swift
//  NMG News
//
//  Created by James Kong on 30/12/2023.
//  Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation

public protocol VideoPlayerSourceProtocol: Equatable, VideoDisplayable  {
    var videoURL: String { get set }
    var title: String { get set }
    var imageURL: String? { get set }
}

extension VideoPlayerSourceProtocol {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.videoURL == rhs.videoURL
    }
}
