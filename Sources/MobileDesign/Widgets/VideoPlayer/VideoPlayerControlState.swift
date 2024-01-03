//
//  VideoPlayerControlState.swift
//  NMG News
//
//  Created by James Kong on 30/12/2023.
//  Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation

public enum VideoPlayerControlState: StringLiteralType, CaseIterable {
    case INIT
    case LOADING
    case PLAYING
    case PAUSED
    case COMPLETED
    case ERROR
    case READY
    case REPLAY
    case UNKNOWN
}
