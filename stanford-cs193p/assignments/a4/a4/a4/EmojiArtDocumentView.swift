//
//  EmojiArtDocumentView.swift
//  a4
//
//  Created by Lor Worwag on 9/11/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    
    @ObservedObject var document: EmojiArtDocument = EmojiArtDocument()
    @State private var selectedEmojis: Set<EmojiArt.Emoji> = []
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(EmojiArtDocument.palette.map { String($0) }, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.defaultEmojiSize))
                            .onDrag{ NSItemProvider(object: emoji as NSString) }
                    }
                }
            }
            .padding(.horizontal)
            GeometryReader { geometry in
                ZStack {
                    Color.white.overlay(
                        OptionalImage(uiImage: self.document.backgroundImage)
                            .scaleEffect(self.zoomScale)
                            .offset(self.panOffset)
                    )
                        .gesture(self.doubleTapToZoom(in: geometry.size))
                    ForEach(self.document.emojis) { emoji in
                        Text(emoji.text)
                            .font(animatableWithSize: emoji.fontSize * self.zoomScale)
                            .background(
                                Rectangle()
                                    .stroke(Color.black)
                                    .opacity(selectedEmojis.contains(matching: emoji) ? 1 : 0)
                            )
                            .position(self.position(for: emoji, in: geometry.size))
                            // select emojis gesture
                            .gesture(emojiSelectDeselectTapGesture(emoji))
                    }
                    
                }
                .clipped()
                .gesture(self.panGesture())
                .gesture(self.zoomGesture())
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                    // SwiftUI bug (as of 13.4)? the location is supposed to be in our coordinate system
                    // however, the y coordinate appears to be in the global coordinate system
                    var location = CGPoint(x: location.x, y: geometry.convert(location, from: .global).y)
                    location = CGPoint(x: location.x - geometry.size.width/2, y: location.y - geometry.size.height/2)
                    location = CGPoint(x: location.x - self.panOffset.width, y: location.y - self.panOffset.height)
                    location = CGPoint(x: location.x / self.zoomScale, y: location.y / self.zoomScale)
                    return self.drop(providers: providers, at: location)
                }
            }

        }
    }
    
    // MARK: - Select emojis
    
    private func emojiSelectDeselectTapGesture(_ emoji: EmojiArt.Emoji) -> some Gesture {
        TapGesture(count: 1)
            .onEnded {
                selectedEmojis.selectDeselectEmoji(emoji)
        }
    }
    
    // MARK: - Zoom and move entire view
    
    @State private var steadyStateZoomScale: CGFloat = 1.0
    @GestureState private var gestureZoomScale: CGFloat = 1.0
    private var zoomScale: CGFloat {
        steadyStateZoomScale * (selectedEmojis.isEmpty ? gestureZoomScale : 1.0)
    }
    private let defaultEmojiSize: CGFloat = 40.0
    
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, transaction in
                // check if emojis are selected, and zooming emojis dynamically
                if selectedEmojis.isEmpty {
                    gestureZoomScale = latestGestureScale
                } else {
                    selectedEmojis.forEach { emoji in
                        self.document.scaleEmoji(emoji, by: latestGestureScale)
                    }
                }
                
            }
            .onEnded { finalGestureScale in
                // check if emojis are selected, and only zooming them
                if selectedEmojis.isEmpty {
                    self.steadyStateZoomScale *= finalGestureScale
                } else {
                    selectedEmojis.forEach { emoji in
                        self.document.scaleEmoji(emoji, by: finalGestureScale)
                    }
                }
            }
    }
    
    @State private var steadyStatePanOffset: CGSize = .zero
    @GestureState private var gesturePanOffset: CGSize = .zero
    
    private var panOffset: CGSize {
        (steadyStatePanOffset + (selectedEmojis.isEmpty ? gesturePanOffset : .zero)) * zoomScale
    }
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, trransaction in
                if selectedEmojis.isEmpty {
                    gesturePanOffset = latestDragGestureValue.translation / self.zoomScale
                } else {
                    selectedEmojis.forEach { emoji in
                        self.document.moveEmoji(emoji, by: latestDragGestureValue.translation)
                    }
                }
            }
            .onEnded { finalDragGestureValue in
                // check if emojis are selected, and only panning them
                if selectedEmojis.isEmpty {
                    self.steadyStatePanOffset = self.steadyStatePanOffset + (finalDragGestureValue.translation / self.zoomScale)
                } else {
                    selectedEmojis.forEach { emoji in
                        self.document.moveEmoji(emoji, by: finalDragGestureValue.translation)
                    }
                }
            }
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    self.zoomToFit(self.document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            self.steadyStatePanOffset = .zero
            self.steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
    private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        var location = emoji.location
        location = CGPoint(x: location.x * zoomScale, y: location.y * zoomScale)
        location = CGPoint(x: location.x + size.width/2, y: location.y + size.height/2)
        location = CGPoint(x: location.x + self.panOffset.width, y: location.y + self.panOffset.height)
        return location
    }
    
    private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool {
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            self.document.setBackgroundURL(url)
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                self.document.addEmoji(string, at: location, size: self.defaultEmojiSize)
            }
        }
        return found
    }
    
}


struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}
