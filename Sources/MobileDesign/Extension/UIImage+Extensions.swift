//
//  File.swift
//  
//
//  Created by Joey Sun on 2023/11/29.
//

import UIKit
import SwiftUI

extension UIImage {
    static func image(from baseFolder: String, named name: String, bundle: Bundle = Bundle.module) -> UIImage? {
        UIImage(named: "\(baseFolder)/\(name)", in: bundle, with: nil)
    }

    public var uiImage: Image {
        Image(uiImage: self)
    }
}
