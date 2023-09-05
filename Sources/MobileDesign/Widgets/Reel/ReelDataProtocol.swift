//
// ReelDataProtocol.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation
import AVKit

public protocol ReelDataProtocol: Identifiable, Equatable, Hashable {
    associatedtype MedieFile: MediaFileConsumerable
    var id: String { get }
    var title: String { get }
    var player: AVPlayer? { get }
    var mediaFile: MedieFile { get }
}
