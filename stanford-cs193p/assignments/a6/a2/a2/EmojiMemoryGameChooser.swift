//
//  EmojiMemoryGameChooser.swift
//  a2
//
//  Created by Lor Worwag on 12/6/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameChooser: View {
    
    @EnvironmentObject var store: EmojiMemoryGameStore
    @State private var editMode: EditMode = .inactive
    
    @State private var showThemeEditor = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.documents) { document in
                    NavigationLink(destination: EmojiMemoryGameView(document: document).navigationBarTitle(document.theme.name)) {
                        Text(document.theme.name)
                            .onTapGesture {
                                print("onTapGesture: \(document.id)")
                                if editMode.isEditing { self.showThemeEditor = true }
                            }
                            .popover(isPresented: $showThemeEditor) {
                                Text("popover: \(document.id.uuidString)")
                                ThemeEditor(isShowing: $showThemeEditor)
                                    .environmentObject(document)
                                    .frame(minWidth: 300, minHeight: 500)
                            }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { self.store.documents[$0] }.forEach { document in
                        self.store.removeDocument(document)
                    }
                }
            }
            .navigationBarTitle(self.store.storeName)
            .navigationBarItems(
                leading: Button(
                    action: { self.store.addDocument() },
                    label: { Image(systemName: "plus").imageScale(.large) }),
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
        }
    }
    
}

// MARK: - ThemeEditor

struct ThemeEditor: View {
    
    @EnvironmentObject var chosenDocument: EmojiMemoryGame
    @Binding var isShowing: Bool
    
    @State private var themeName: String = ""
    @State private var emojisToAdd: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                Text("Theme Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(
                        action: {
                            print("Done: \(chosenDocument.id)")
                            self.isShowing = false
                        },
                        label: { Text("Done") }).padding()
                }
            }
            Divider()
            Form {
                Section {
                    TextField("Theme Name", text: $themeName, onEditingChanged: { began in
                        if !began {
                            print("Theme Name: \(chosenDocument.id)")
                            self.chosenDocument.setThemeName(themeName)
                        }
                    })
                    TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: { began in
                        if !began {
                            self.chosenDocument.addEmoji(emojisToAdd)
                            self.emojisToAdd = ""
                        }
                    })
                }
//                Section(header: Text("Remove Emojis")) {
//                    Grid(chosenDocument.theme.content.map { String($0) }, id: \.self) { emoji in
//                        Text(emoji).font(Font.system(size: self.fontSize))
//                            .onTapGesture {
//                                self.chosenDocument.removeEmoji(emoji)
//                            }
//                    }
//                    .frame(height: self.height)
//                }
                
            }
        }
        .onAppear { self.themeName = self.chosenDocument.theme.name }
    }
    
    // MARK: - Drawing Constant
    let fontSize: CGFloat = 40
    var height: CGFloat {
        CGFloat((chosenDocument.theme.content.count - 1) / 6) * 70 + 70
    }
    
}

