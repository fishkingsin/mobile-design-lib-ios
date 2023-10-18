//
//  SwiftUIView.swift
//  
//
//  Created by James Kong on 21/9/2023.
//

import SwiftUI
import WebKit
public class WebViewModel: ObservableObject {
    @Published public var isLoading: Bool
    public init(isLoading: Bool ) {
        self.isLoading = isLoading
    }
}
public struct WebView: ViewRepresentableHelper {

    // swiftlint:disable:next unused_closure_parameter
    public var completion = { (view: WKWebView) in } // 🎁 This has a gift for you
    public var configuration: WKWebViewConfiguration?

    public init(configuration: WKWebViewConfiguration? = nil, completion: @escaping (WKWebView) -> Void) {
        self.configuration = configuration
        self.completion = completion

    }

    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    public class Coordinator: NSObject, WKNavigationDelegate {
        public override init() {
        }

        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        }
    }

    public func new(_ context: Context) -> WKWebView {
        var webview: WKWebView!
        guard let configuration = configuration else {
            webview = WKWebView(frame: .zero)
            webview.navigationDelegate = context.coordinator
            return webview
        }
        webview = WKWebView(frame: .zero, configuration: configuration)
        webview.navigationDelegate = context.coordinator
        return webview
    }
}

public struct LoadingView<Content>: View where Content: View {
    @Binding public var isShowing: Bool
    public var content: () -> Content

    public init(isShowing: Binding<Bool>, content: @escaping () -> Content) {
        self._isShowing = isShowing
        self.content = content
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("Loading...")
                    ActivityIndicatorView(isAnimating: .constant(true), style: .large)
                }
                .background(Rectangle().fill(ThemeManager.shared.currentTheme.colors.neutralGray2.color))
                .opacity(self.isShowing ? 1 : 0)
                .frame(width: geometry.size.width, height: geometry.size.height)

            }
        }
    }
}

public struct WebViewContent: View {
    @State var model = WebViewModel(isLoading: true)
    public init() {
    }
    public var body: some View {
        LoadingView(isShowing: self.$model.isLoading) {
            WebView() {
                $0.load(URLRequest(url: .init(string: "https://google.com")!))
            }
        }
    }
}
// swiftlint:disable:next type_name
struct WebView_URL_Previews: PreviewProvider {
    static var previews: some View {
        WebView() {
            $0.load(URLRequest(url: .init(string: "https://google.com")!))
        }
    }
}
// swiftlint:disable:next type_name
struct WebView_iFrame_Previews: PreviewProvider {

    static var previews: some View {
        // swiftlint:disable line_length
        let content = """
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/UfhiodCyfUo?si=O8mGRXESndrjd5b6&amp&rel=0;controls=0" title="EDTV" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope;" allowfullscreen></iframe>
"""
        WebView() {
            $0.loadHTMLString(content, baseURL: nil)
        }
    }
}

