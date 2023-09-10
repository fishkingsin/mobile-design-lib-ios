//
// Bundle+Extension.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import Foundation

extension Bundle {
    public func locateFirst(forResource: String, withExtension: String) -> URL? {
        for b in Bundle.allBundles {
            if let u = b.url(forResource: forResource, withExtension: withExtension) {
                return u
            }
        }
        return nil
    }

}
