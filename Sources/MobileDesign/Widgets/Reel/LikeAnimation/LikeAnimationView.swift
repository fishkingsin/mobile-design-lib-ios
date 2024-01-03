//
//  SwiftUIView.swift
//
//
//  Created by Joey Sun on 2023/9/13.
//

import SwiftUI

public struct LikeAnimationView: View {
    static let darkPink = Color( UIColor.color(from: "Default", named: "darkPink")!)
    static let lightGreen = Color( UIColor.color(from: "Default", named: "lightGreen")!)
    static let lightBlue = Color( UIColor.color(from: "Default", named: "lightBlue")!)
    static let lightRed = Color( UIColor.color(from: "Default", named: "lightRed")!)
    static let defaultColor = Color(UIColor.color(from: "Common", named: "NeutralGray90")!)

    public var buttonTappedCompletion: ((Bool) -> Void)?
    @State public var buttonTapped: Bool = false
    @State private var showRedHeart: Bool = false
    @State private var redHeartScale: CGFloat = 0.2
    @State private var hideTwoCircles: Bool = true
    @State private var colorCircleScaleRate: CGFloat = 0.2
    @State private var colorCircleColor: Color = darkPink
    @State private var whiteCircleScaleRate: CGFloat = 0.01
    /// For the binary circle.
    @State private var binaryCircleSpacing: CGFloat = 0.0
    @State private var binaryCircleRotateAngle: CGFloat = 45.0
    @State private var binaryCircleScaleRate: CGFloat = 1.0
    @State private var binaryCircleOffset: CGFloat = -58
    @State private var showBinaryCircleRing: Bool = false

    @State private var isLike: Bool = false
    @Binding var externalButtonTapped: Bool?

    public init(buttonTappedCompletion: ((Bool) -> Void)?, externalButtonTapped: Binding<Bool?>) {
        self.buttonTappedCompletion = buttonTappedCompletion
        self._externalButtonTapped = externalButtonTapped
        let boolValue: Bool = externalButtonTapped.wrappedValue ?? false
        self._isLike = State(initialValue: boolValue)
        self._showRedHeart = State(initialValue: boolValue)
    }

    public var body: some View {
        ZStack {
            Circle()
                .foregroundColor(colorCircleColor)
                .scaleEffect(colorCircleScaleRate)
                .frame(width: 20, height: 20)
                .opacity(self.hideTwoCircles ? 0: 1)

            Circle()
                .stroke(Color.white, lineWidth: 1)
                .scaleEffect(whiteCircleScaleRate)
                .frame(width: 20, height: 20)
                .opacity(self.hideTwoCircles ? 0: 1)

            binaryCircleRing
                .opacity(self.showBinaryCircleRing ? 1: 0)

            Button {
                self.isLike ? restoreButton(): like()
                if let completion = self.buttonTappedCompletion {
                    completion(self.isLike)
                }
            } label: {
                Image(uiImage: self.isLike ? ThemeManager.shared.currentTheme.icons.heartFill: ThemeManager.shared.currentTheme.icons.heart)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(self.showRedHeart ? LikeAnimationView.darkPink: LikeAnimationView.defaultColor)
                    .frame(width: 20, height: 20)
                    .scaleEffect(self.buttonTapped ? self.redHeartScale: 1)
            }
            .buttonStyle(.plain)
            .opacity(self.showRedHeart ? 1: self.buttonTapped ? 0: 1)
        }.onChange(of: externalButtonTapped) { newValue in
            guard let newValue = newValue else { return }
            isLike = newValue
            showRedHeart = newValue
        }
    }
}

struct LikeAnimationView_Previews: PreviewProvider {
    @State static var externalButtonTapped: Bool? = false
    static var previews: some View {
        LikeAnimationView(buttonTappedCompletion: nil, externalButtonTapped: $externalButtonTapped)
    }
}

extension LikeAnimationView {
    private var binaryCircleRing: some View {
        ZStack {
            BinaryCircle(spacing: $binaryCircleSpacing, rotateAngle: $binaryCircleRotateAngle, scaleRate: $binaryCircleScaleRate)
                .offset(y: self.binaryCircleOffset)
                .frame(width: 7, height: 6)
                .rotationEffect(.degrees(0), anchor: .center)
                .foregroundColor(LikeAnimationView.lightBlue)

            BinaryCircle(spacing: $binaryCircleSpacing, rotateAngle: $binaryCircleRotateAngle, scaleRate: $binaryCircleScaleRate)
                .offset(y: self.binaryCircleOffset)
                .frame(width: 7, height: 6)
                .rotationEffect(.degrees(360/7), anchor: .center)
                .foregroundColor(.purple)

            BinaryCircle(spacing: $binaryCircleSpacing, rotateAngle: $binaryCircleRotateAngle, scaleRate: $binaryCircleScaleRate)
                .offset(y: self.binaryCircleOffset)
                .frame(width: 7, height: 6)
                .rotationEffect(.degrees(360*2/7), anchor: .center)
                .foregroundColor(LikeAnimationView.lightGreen)

            BinaryCircle(spacing: $binaryCircleSpacing, rotateAngle: $binaryCircleRotateAngle, scaleRate: $binaryCircleScaleRate)
                .offset(y: self.binaryCircleOffset)
                .frame(width: 7, height: 6)
                .rotationEffect(.degrees(360*3/7), anchor: .center)
                .foregroundColor(LikeAnimationView.lightRed)

            BinaryCircle(spacing: $binaryCircleSpacing, rotateAngle: $binaryCircleRotateAngle, scaleRate: $binaryCircleScaleRate)
                .offset(y: self.binaryCircleOffset)
                .frame(width: 7, height: 6)
                .rotationEffect(.degrees(360*4/7), anchor: .center)
                .foregroundColor(LikeAnimationView.lightBlue)

            BinaryCircle(spacing: $binaryCircleSpacing, rotateAngle: $binaryCircleRotateAngle, scaleRate: $binaryCircleScaleRate)
                .offset(y: self.binaryCircleOffset)
                .frame(width: 7, height: 6)
                .rotationEffect(.degrees(360*5/7), anchor: .center)
                .foregroundColor(.purple)

            BinaryCircle(spacing: $binaryCircleSpacing, rotateAngle: $binaryCircleRotateAngle, scaleRate: $binaryCircleScaleRate)
                .offset(y: self.binaryCircleOffset)
                .frame(width: 7, height: 6)
                .rotationEffect(.degrees(360*6/7), anchor: .center)
                .foregroundColor(LikeAnimationView.lightGreen)
        }
    }
}

extension LikeAnimationView {
    private func like() {
        withAnimation(.easeInOut(duration: 0.01)) {
            self.buttonTapped.toggle()
            self.isLike.toggle()
            self.hideTwoCircles.toggle()
        }
        withAnimation(.easeInOut(duration: 0.2)) {
            self.colorCircleScaleRate = 1.2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 0.3)) {
                self.colorCircleColor = .clear
                self.whiteCircleScaleRate = 1.13
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.easeInOut(duration: 0.1)) {
                self.showBinaryCircleRing.toggle()
                self.hideTwoCircles.toggle()
                self.showRedHeart.toggle()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.binaryCircleRotateAngle = -45
                self.binaryCircleOffset = -30
                self.binaryCircleScaleRate = 1.2
                self.binaryCircleSpacing = 5
            }

        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.1)) {
                self.redHeartScale = 1.0
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.easeInOut(duration: 0.2)) {
                self.showBinaryCircleRing.toggle()
            }
        }
    }

    private func restoreButton() {
        self.buttonTapped = false
        self.redHeartScale = 0.2
        self.showRedHeart = false
        self.colorCircleScaleRate = 0.2
        self.colorCircleColor = LikeAnimationView.darkPink
        self.whiteCircleScaleRate = 0.01
        self.binaryCircleSpacing = 0.0
        self.binaryCircleRotateAngle = 45.0
        self.binaryCircleScaleRate = 1.0
        self.binaryCircleOffset = -10
        self.showBinaryCircleRing = false
        self.hideTwoCircles = true
        self.isLike = false
    }
}
