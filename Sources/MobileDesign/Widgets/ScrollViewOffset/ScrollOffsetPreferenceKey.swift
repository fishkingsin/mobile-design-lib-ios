//
//  File.swift
//  
//
//  Created by James Kong on 22/12/2023.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {

    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
