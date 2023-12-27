//
//  SwiftUIView.swift
//
//
//  Created by James Kong on 27/12/2023.
//

import SwiftUI
import ActiveLabel

public struct HashtagsMentionsTextView: UIViewRepresentable {
    let text: String
    let onHashtagTap: (String) -> Void
    let onMentionTap: (String) -> Void
    let onURLTap: (URL) -> Void
    let theme: NMGThemeable

    public init(text: String, preferredMaxLayoutWidth: CGFloat = 50, theme: NMGThemeable = ThemeManager.shared.currentTheme, onHashtagTap: @escaping (String) -> Void, onMentionTap: @escaping (String) -> Void, onURLTap: @escaping (URL) -> Void) {
        self.text = text
        self.onHashtagTap = onHashtagTap
        self.onMentionTap = onMentionTap
        self.onURLTap = onURLTap
        self.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        self.theme = theme
    }

    var preferredMaxLayoutWidth: CGFloat = UIScreen.main.bounds.width
    public func makeUIView(context: UIViewRepresentableContext<HashtagsMentionsTextView>) -> UILabel {
        let label = ActiveLabel()
        label.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
        label.numberOfLines = 10
        label.enabledTypes = [.mention, .hashtag, .url]
        label.hashtagColor = theme.colors.primaryMain // optional, adjust base on biz needs can be theme.colors.hashtag
        label.mentionColor = theme.colors.primaryMain // optional, adjust base on biz needs can be theme.colors.mention
        label.URLColor = theme.colors.primaryMain // optional
        label.text = text
        label.textColor = theme.colors.neutralGray90 // UITraitCollection().userInterfaceStyle == .light ? theme.colors.neutralGray90 : .white
        label.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        label.contentMode = .scaleAspectFill

        // MARK: - handle types

        label.handleHashtagTap { hashtag in
            onHashtagTap(hashtag)

        }
        label.handleURLTap { url in
            onURLTap(url)
        }
        label.handleMentionTap { mention in
            onMentionTap(mention)
        }
        return label
    }

    public func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<HashtagsMentionsTextView>) { }
}

struct HashtagsMentionsTextViewPreview: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(1...10, id: \.self) { item in
                    HStack(spacing: CGFloat(item), content: {

                        HashtagsMentionsTextView(
                            text: "I am #hashtags or #hashtags# and @mentions in SwiftUI. I am #hashtags or #hashtags# and @mentions in SwiftUI. 這是在 SwiftUI 中的一個 #標簽 和 @提及 的超鏈接。 這是在 SwiftUI 中的一個 #標簽 和 @提及 的超鏈接。",
                            preferredMaxLayoutWidth: UIScreen.main.bounds.width - CGFloat(item * 10)
                        ) {
                            print("onHashtagTap \($0)")
                        } onMentionTap: {
                            print("onMentionTap \($0)")
                        } onURLTap: {
                            print("onURLTap \($0)")
                        }.fixedSize(horizontal: true, vertical: true)
                    })
                    Divider()
                }
            }
        }
    }
}

#Preview {
    HashtagsMentionsTextViewPreview()
}
