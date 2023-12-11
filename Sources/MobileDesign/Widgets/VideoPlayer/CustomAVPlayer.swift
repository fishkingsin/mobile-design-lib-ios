//
//  File.swift
//
//
//  Created by Joey Sun on 2023/12/11.
//

import Foundation
import SwiftUI
import AVKit

struct CustomAVPlayer<
    PlaceholderView: View, PlayFinishView: View
>: View {
    var size: CGSize
    var safeArea: EdgeInsets
    let placeholderView: () -> PlaceholderView?
    let finishView: (() -> PlayFinishView)?
    
    
    /// View Properties
    @State private var player: AVPlayer? = {
        
        return AVPlayer(url: URL(string: "https://player.vimeo.com/external/873243977.m3u8?s=d35bb833f41cb5fdaf5bb77237cb417ea7842002&logging=false")!)
    }()
    @State private var showPlayerControls: Bool = false
    @State private var isPlaying: Bool = false
    @State private var isPlayerReady: Bool = false
    @State private var timeoutTask: DispatchWorkItem?
    @State private var isFinishedPlaying: Bool = false
    /// Video Seeker Properties
    @GestureState private var isDragging: Bool = false
    @State private var isSeeking: Bool = false
    @State private var progress: CGFloat = 0
    @State private var lastDraggedProgress: CGFloat = 0
    @State private var isObserverAdded: Bool = false
    
    @State private var playerStatusObserver: NSKeyValueObservation?
    /// Rotation Properties
    @State private var isRotated: Bool = false
    @State private var deviceRotation: UIDeviceOrientation = UIDevice.current.orientation
    @Environment(\.scenePhase) private var scenePhase
    
    public init(
        size: CGSize,
        safeArea: EdgeInsets,
        placeholderView: @escaping () -> PlaceholderView,
        finishView: (() -> PlayFinishView)? = nil
    ) {
        self.size = size
        self.safeArea = safeArea
        self.placeholderView = placeholderView
        self.finishView = finishView
    }
    
    var body: some View {
        VStack(spacing: 0) {
            /// Swapping Size When Rotated
            let videoPlayerSize: CGSize = .init(width: isRotated ? size.height : size.width, height: isRotated ? size.width : (9.0/16.0 * size.width))
            
            /// Custom Vide Player
            ZStack {
                if let player {
                    CustomVideoPlayer(player: player)
                        .overlay {
                            Rectangle()
                                .fill(.black.opacity(0.4))
                                .opacity(showPlayerControls || isDragging ? 1 : 0)
                            /// Animating Dragging State
                                .animation(.easeInOut(duration: 0.35), value: isDragging)
                                .overlay {
                                    PlayBackControls()
                                }
                        }
                    
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                showPlayerControls.toggle()
                            }
                            
                            /// Timing Out Controls, Only If the Video is Playing
                            if isPlaying {
                                timeoutControls()
                            }
                        }
                        .overlay(alignment: .bottom) {
                            VideoSeekerView(videoPlayerSize)
                                .offset(y: isRotated ? -5 : 0)
                        }
                }
                if !isPlayerReady {
                    placeholderView()
                }
                if isFinishedPlaying {
                    finishView?()
                }
            }
            .background(content: {
                Rectangle()
                    .fill(.black)
                /// Since View is Rotated the Trailing side is Bottom
                /// Since View is Rotated the Leading side is Top
                    .padding(deviceRotation == .landscapeRight ? .leading : .trailing, isRotated ? -safeArea.top : 0)
                    .padding(deviceRotation == .landscapeRight ? .trailing : .leading, isRotated ? -safeArea.top : 0)
            })
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        if -value.translation.height > 100 {
                            /// Rotate Player
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isRotated = true
                            }
                        } else {
                            /// Go To Normal Position
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isRotated = false
                            }
                        }
                    })
            )
            .frame(width: videoPlayerSize.width, height: videoPlayerSize.height)
            /// To Avoid Other View Expansion Set it;s Native View height
            .frame(width: size.width, height: size.height / 3.5, alignment: deviceRotation == .landscapeRight ? .bottomTrailing : .bottomLeading)
            .offset(y: isRotated ? -((size.height) / 3.5) : 0)
            .rotationEffect(.init(degrees: isRotated ? (deviceRotation == .landscapeRight ? -90 : 90) : 0), anchor: deviceRotation == .landscapeRight ? .topTrailing : .topLeading)
            /// Making it Top View
            .zIndex(10000)
        }
        .padding(.top, isRotated ? -safeArea.top : 0)
        .onAppear {
            guard !isObserverAdded else { return }
            /// Adding Observer to update seeker when the video is Playing
            player?.addPeriodicTimeObserver(forInterval: .init(seconds: 1, preferredTimescale: 600), queue: .main, using: { time in
                /// Calculating Video Progress
                if let currentPlayerItem = player?.currentItem {
                    let totalDuration = currentPlayerItem.duration.seconds
                    guard let currentDuration = player?.currentTime().seconds else { return }
                    
                    let calculatedProgress = currentDuration / totalDuration
                    
                    if !isSeeking {
                        progress = calculatedProgress
                        lastDraggedProgress = progress
                    }
                    if calculatedProgress >= 1 {
                        /// Video Finished Playing
                        isFinishedPlaying = true
                        isPlaying = false
                    }
                }
            })
            
            isObserverAdded = true
            
            /// Before Generating Thumbnails, Check if the Video is Loaded
            playerStatusObserver = player?.observe(\.status, options: .new, changeHandler: { player, _ in
                if player.status == .readyToPlay {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        isPlayerReady = true
                    }
                }
            })
        }
        .onDisappear {
            /// Clearing Observers
            player?.pause()
            playerStatusObserver?.invalidate()
            player = nil
        }
        .onChange(of: scenePhase, perform: { newValue in
            if newValue == .background && isPlaying {
                isPlaying = false
            }
        })
        .onChange(of: progress) { newValue in
            if newValue <= 1 {
                isFinishedPlaying = false
            }
        }
        .onRotate { rotation in
            if rotation.isValidInterfaceOrientation {
                deviceRotation = rotation
                withAnimation(.easeInOut(duration: 0.2)) {
                    isRotated = (deviceRotation == .landscapeLeft || deviceRotation == .landscapeRight)
                }
            }
        }
    }
    
    
    /// Video Seeker View
    @ViewBuilder
    func VideoSeekerView(_ videoSize: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            if showPlayerControls || isDragging {
                HStack() {
                    Text("\(timeString(for: player?.currentTime().seconds ?? 0))")
                        .font(ThemeManager.shared.currentTheme.fonts.eleRegular12.uiFont)
                        .foregroundColor(.white)
                        .padding(.leading, 12)
                    Text("/ \(timeString(for: player?.currentItem?.duration.seconds ?? 0))")
                        .font(ThemeManager.shared.currentTheme.fonts.eleRegular12.uiFont)
                        .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                    Spacer()
                    if !isRotated {
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .foregroundColor(.white)
                            .padding(15).onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    isRotated = true
                                }
                            }
                    }
                }
            }
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.white)
                
                Rectangle()
                    .fill(ThemeManager.shared.currentTheme.colors.primaryMain.color)
                    .frame(width: max(videoSize.width * progress, 0))
            }
            .frame(height: 3)
            .overlay(alignment: .leading) {
                Circle()
                    .fill(ThemeManager.shared.currentTheme.colors.primaryMain.color)
                    .frame(width: 15, height: 15)
                /// Showing Drag Knob Only When Dragging
                    .scaleEffect(showPlayerControls || isDragging ? 1 : 0.001, anchor: .init(x: progress, y: 0.5))
                /// For More Dragging Space
                    .frame(width: 50, height: 50)
                    .contentShape(Rectangle())
                /// Moving Along Side With Gesture Progress
                    .offset(x: videoSize.width * progress)
                    .gesture(
                        DragGesture()
                            .updating($isDragging, body: { _, out, _ in
                                out = true
                            })
                            .onChanged({ value in
                                /// Cancelling Existing Timeout Task
                                if let timeoutTask {
                                    timeoutTask.cancel()
                                }
                                
                                /// Calculating Progress
                                let translationX: CGFloat = value.translation.width
                                let calculatedProgress = (translationX / videoSize.width) + lastDraggedProgress
                                
                                progress = max(min(calculatedProgress, 1), 0)
                                isSeeking = true
                                
                            })
                            .onEnded({ value in
                                /// Storing Last Known Progress
                                lastDraggedProgress = progress
                                /// Seeking Video To Dragged Time
                                if let currentPlayerItem = player?.currentItem {
                                    let totalDuration = currentPlayerItem.duration.seconds
                                    
                                    player?.seek(to: .init(seconds: totalDuration * progress, preferredTimescale: 600))
                                    
                                    /// Re-Scheduling Timeout Task
                                    if isPlaying {
                                        timeoutControls()
                                    }
                                    
                                    /// Releasing With Slight Delay
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        isSeeking = false
                                    }
                                }
                            })
                    )
                    .offset(x: progress * videoSize.width > 15 ? (progress * -15) : 0)
                    .frame(width: 15, height: 15)
            }
            
        }
    }
    
    /// Playback Controls View
    @ViewBuilder
    func PlayBackControls() -> some View {
        VStack(spacing: 0) {
            if isRotated {
                HStack() {
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isRotated = false
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 16)
                    
                    Spacer() // This will push the button to the left
                }.padding(.top, 20)
            }
            
            Spacer()
            
            HStack(spacing: 25) {
                Button {
                    
                } label: {
                    Image(systemName: "backward.end.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(15)
                        .background {
                            Circle()
                                .fill(.black.opacity(0.35))
                        }
                }
                /// Disabling Button
                /// Since we have no action's for it
                .disabled(true)
                .opacity(0.6)
                
                
                Button {
                    if isFinishedPlaying {
                        /// Setting Video to Start and Playing Again
                        isFinishedPlaying = false
                        player?.seek(to: .zero)
                        progress = .zero
                        lastDraggedProgress = .zero
                    }
                    
                    /// Changing Video Status to Play/Pause based on user input
                    if isPlaying {
                        /// Pause Video
                        player?.pause()
                        /// Cancelling Timeout Task when the Video is Paused
                        if let timeoutTask {
                            timeoutTask.cancel()
                        }
                    } else {
                        /// Play Video
                        player?.play()
                        timeoutControls()
                    }
                    
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isPlaying.toggle()
                    }
                } label: {
                    /// Changing Icon based on Video Status
                    /// Changing Icon When Video was Finished Playing
                    Image(systemName: isFinishedPlaying ? "arrow.clockwise" : (isPlaying ? "pause.fill" : "play.fill"))
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(15)
                        .background {
                            Circle()
                                .fill(.black.opacity(0.35))
                        }
                }
                .scaleEffect(1.1)
                
                Button {
                    
                } label: {
                    Image(systemName: "forward.end.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(15)
                        .background {
                            Circle()
                                .fill(.black.opacity(0.35))
                        }
                }
                .disabled(true)
                .opacity(0.6)
            }
            /// Hiding Controls When Dragging
            .opacity(showPlayerControls && !isDragging ? 1 : 0)
            .animation(.easeInOut(duration: 0.2), value: showPlayerControls && !isDragging)
            Spacer()
        }
        
        
    }
    
    /// Timing Out Play back controls
    /// After some 2-5 Seconds
    func timeoutControls() {
        /// Cancelling Already Pending Timeout Task
        if let timeoutTask {
            timeoutTask.cancel()
        }
        
        timeoutTask = .init(block: {
            withAnimation(.easeInOut(duration: 0.35)) {
                showPlayerControls = false
            }
        })
        
        /// Scheduling Task
        if let timeoutTask {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: timeoutTask)
        }
    }
    
    /// Convert time in seconds to a formatted string (hh:mm:ss)
    func timeString(for timeInSeconds: Double) -> String {
        // Check if timeInSeconds is finite and not NaN
        guard timeInSeconds.isFinite && !timeInSeconds.isNaN else {
            return "00:00" // Return a default value or handle the error as needed
        }
        
        let minutes = Int((timeInSeconds.truncatingRemainder(dividingBy: 3600)) / 60)
        let seconds = Int(timeInSeconds.truncatingRemainder(dividingBy: 60))
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}

struct CustomAVPlayer_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            CustomAVPlayer<Text, Text>(size: size, safeArea: safeArea) {
                Text("loading")
            }
        }
        .preferredColorScheme(.dark)
    }
}
