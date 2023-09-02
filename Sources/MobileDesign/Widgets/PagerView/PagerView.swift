//
// PagerView.swift
//
// Copyright © 2023 New Media Group. All rights reserved.
//

import SwiftUI

public struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    
    let bounce: Bool
    
    @GestureState private var translation: CGFloat = 0
    
    public init(pageCount: Int, currentIndex: Binding<Int>, bounce: Bool = true, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self.bounce = bounce
        self._currentIndex = currentIndex
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .offset(x: self.translation)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    if !bounce && ((currentIndex == 0 && value.startLocation.x < value.location.x) || (currentIndex == pageCount - 1 && value.startLocation.x > value.location.x)) {
                        return
                    }
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
        }
    }
}

struct PagerViewDemo: View {
    @State private var currentPage: Int
    
    public init() {
        self.currentPage = 2
    }
    
    public var body: some View {
        ZStack {
            Color.gray
            VStack(alignment: .center, spacing: 10) {
                PagerView(pageCount: 5, currentIndex: $currentPage) {
                    
                    /*ShareCardViewBuilderNAV(data: NAVData(
                        headnote: "2022-02-10 14:35",
                        title: "累計盈虧",
                        subtitle: "由 2021-11-02 至 2021-11-30",
                        volumn: "-2,328.31",
                        currency: "HKD",
                        headline: "最高資產淨值(港元)\n59,120",
                        leadingChartTitle: "期初",
                        trailingChartTitle: "期末",
                        leadingFootnote: "2021-11-01",
                        trailingFootnote: "2021-11-30",
                        chartData: mockChartData
                    ))
                    
                    ShareCardViewBuilderSingleStock(
                        SingleStockData(
                            timestamp: "2022-02-10 14:35",
                            exchange: "HK",
                            symbolName: "晨鳴紙業 (01812)",
                            postfitLossValue: "+18.25%",
                            currentPrice: "48.082",
                            averagePrice: "48.082",
                            trend: .UP
                        ))
                    
                    
                    ShareCardViewBuilderStockRatio(
                        data: StockRatioData(
                            timestamp: "2022-02-10 14:35",
                            title: "我的港股組合",
                            centerText: """
        持股
        Top 5
        """,
                            colorScheme: [
                                UIColor(red: 34/255, green: 81/255, blue: 128/255, alpha: 1),
                                UIColor(red: 53/255, green: 87/255, blue: 104/255, alpha: 1),
                                UIColor(red: 129/255, green: 159/255, blue: 185/255, alpha: 1),
                                UIColor(red: 82/255, green: 127/255, blue: 50/255, alpha: 1),
                                UIColor(red: 145/255, green: 175/255, blue: 96/255, alpha: 1),
                            ],
                            chartData: [1,2,3,4,5],
                            stocks: [
                                RatioIndicator(
                                    title: "44.20%",
                                    caption: "匯豐控股",
                                    footnote: "500000",
                                    color: UIColor(red: 34/255, green: 81/255, blue: 128/255, alpha: 1)
                                ),
                                RatioIndicator(
                                    title: "44.20%",
                                    caption: "匯豐控股",
                                    footnote: "500000",
                                    color: UIColor(red: 53/255, green: 87/255, blue: 104/255, alpha: 1)
                                ),
                                RatioIndicator(
                                    title: "44.20%",
                                    caption: "匯豐控股",
                                    footnote: "500000",
                                    color: UIColor(red: 129/255, green: 159/255, blue: 185/255, alpha: 1)
                                ),
                                RatioIndicator(
                                    title: "44.20%",
                                    caption: "匯豐控股",
                                    footnote: "500000",
                                    color: UIColor(red: 82/255, green: 127/255, blue: 50/255, alpha: 1)
                                ),
                                RatioIndicator(
                                    title: "44.20%",
                                    caption: "匯豐控股",
                                    footnote: "500000",
                                    color: UIColor(red: 145/255, green: 175/255, blue: 96/255, alpha: 1)
                                ),
                            ]
                        ))
                    
                    ShareCardViewBuilderTodayPNL(TodayPNLData(timestamp: "2022-02-10 14:35", title: "今日盈虧金額", postfitLossValue: "+1000.00", currency: "HKD", trend: .UP, trendStyle: .greenUpRedDown))
                    
                    ShareCardBuilderDefault {
                        Text("Default")
                    }*/
                    
                    
                }
                PageControl(selectedPage: .constant(currentPage + 1),
                            pages: 5,
                            circleDiameter: 5.0,
                            circleMargin: 10.0)
            }
            
            
        }
    }
    
}

struct PagerView_Previews: PreviewProvider {

    static var previews: some View {
        PagerViewDemo()
        
    }
}
