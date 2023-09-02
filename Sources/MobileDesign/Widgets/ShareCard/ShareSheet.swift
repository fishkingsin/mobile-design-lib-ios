//
// ShareSheet.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct ShareSheet: UIViewControllerRepresentable {
    public typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void

    let activityItems: [Any]
    var applicationActivities: [UIActivity]?
    var excludedActivityTypes: [UIActivity.ActivityType]?
    var callback: Callback?

    public init(activityItems: [Any],
                callback: Callback? = nil,
                applicationActivities: [UIActivity]? = nil,
                excludedActivityTypes: [UIActivity.ActivityType]? = nil
    ) {
        self.activityItems = activityItems
        self.callback = callback
        self.applicationActivities = applicationActivities
        self.excludedActivityTypes = excludedActivityTypes
    }

    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}

struct ShareSheet_Previews: PreviewProvider {
    static var previews: some View {
        ShareSheet(activityItems: ["Hello"])
    }
}
