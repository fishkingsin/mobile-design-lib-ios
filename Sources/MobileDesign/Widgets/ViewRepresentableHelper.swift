//
//  ViewRepresentableHelper.swift
//  
//
//  Created by James Kong on 21/9/2023.
//

import Foundation
import SwiftUI
#if os(macOS)
public typealias ViewRepresentable = NSViewRepresentable
public typealias NativeView = NSView
#elseif os(iOS)
public typealias ViewRepresentable = UIViewRepresentable
public typealias NativeView = UIView
#endif

public protocol ViewRepresentableHelper: ViewRepresentable {
    associatedtype ViewType: NativeView
    var completion: (ViewType) -> Void { get set }
    func new(_ context: Context) -> ViewType
}

public extension ViewRepresentableHelper {
    func new(_ context: Context) -> ViewType { ViewType() }
}

public extension ViewRepresentableHelper {
    func makeView(_ context: Context) -> ViewType {
        let view = new(context)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return view
    }
        func updateView(_ view: ViewType, _ context: Context) { completion(view) }

    func makeUIView(context: Context) -> ViewType { makeView(context) }
    func makeNSView(context: Context) -> ViewType { makeView(context) }
    func updateUIView(_ uiView: ViewType, context: Context) { updateView(uiView, context) }
    func updateNSView(_ nsView: ViewType, context: Context) { updateView(nsView, context) }

}
