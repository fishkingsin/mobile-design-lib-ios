//
//  SwiftUIView.swift
//  
//
//  Created by James Kong on 22/12/2023.
//

import SwiftUI

public struct UnderlineTabView: View {
    @State var currentTab = 0
    @Namespace var namespace

    var tabItems: [String] = ["Hello World", "This is", "A Pretty Cool Tab Bar"]

    public init(currentTab: Int = 0) {
        self.currentTab = currentTab
    }

    public var body: some View {
        VStack {
            HStack(alignment: .center) {
                tabBarView
            }
            TabView(selection: self.$currentTab, content: {
                view1.tag(0)
                view2.tag(1)
                view3.tag(2)
            })
            .tabViewStyle(.page(indexDisplayMode: .never))

        }.edgesIgnoringSafeArea(.all)
    }

    var tabBarView: some View {
        ScrollView(.horizontal) {

            HStack(alignment: .center, spacing: 20) {
                ForEach(Array(zip(self.tabItems.indices,
                                  self.tabItems)),
                        id: \.0, content: { index, name in
                    tabBarItem(string: name, tab: index)
                })
            }
            .background(Color.green)

        }
        .background(Color.white)
        .frame(height: 80)
        .edgesIgnoringSafeArea(.top)
    }

    func tabBarItem(string: String, tab: Int) -> some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(string)
                    .font(.system(size: 13, weight: .light, design: .default))
                if self.currentTab == tab {
                    Color
                        .black
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline",
                                               in: namespace, properties: .frame)
                } else {
                    Color.clear.frame(height: 2)
                }
            }.animation(.spring(), value: currentTab)
        }
        .buttonStyle(.plain)
    }

    var view1: some View {
        Color.red.opacity(0.2).edgesIgnoringSafeArea(.all)
    }
    var view2: some View {
        Color.blue.opacity(0.2).edgesIgnoringSafeArea(.all)
    }
    var view3: some View {    Color.yellow.opacity(0.2).edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    UnderlineTabView()
}
