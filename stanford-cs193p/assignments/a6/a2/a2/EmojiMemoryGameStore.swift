//
//  EmojiMemoryGameStore.swift
//  a2
//
//  Created by Lor Worwag on 12/6/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI
import Combine

class EmojiMemoryGameStore: ObservableObject {
    
    let storeName: String
    @Published var documents: Array<EmojiMemoryGame> = []
    private var autosave: AnyCancellable?
    
    init(named name: String = "Emoji Memory Game") {
        self.storeName = name
        let defaultKey = "EmojiMemoryGameStore.\(name)"
        
        // retrieve and convert all documents from UserDefaults
        let propertyList = UserDefaults.standard.object(forKey: defaultKey)
        let uuids = propertyList as? [String] ?? []
        for uuid in uuids {
            documents.append(EmojiMemoryGame(id: UUID(uuidString: uuid)))
        }
        
        // convert and update all documents to UserDefaults
        autosave = $documents.sink { docs in
            var uuids = [String]()
            for doc in docs {
                uuids.append(doc.id.uuidString)
            }
            UserDefaults.standard.set(uuids, forKey: defaultKey)
        }
        
    }
    
    
    func setThemeName(_ name: String, for document: EmojiMemoryGame) {
        if let idx = documents.firstIndex(matching: document) {
            documents[idx].setThemeName(name)
        }
    }
    
    func addDocument(named name: String = "Untitled") {
        documents.append(EmojiMemoryGame())
    }
    
    func removeDocument(_ document: EmojiMemoryGame) {
        if let idx = documents.firstIndex(matching: document) {
            documents.remove(at: idx)
        }
    }
    
    func findDocument(_ document: EmojiMemoryGame) -> EmojiMemoryGame {
        return documents.first(where: { $0 == document })!
    }
    
}
