//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Lor Worwag on 9/10/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import SwiftUI

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
