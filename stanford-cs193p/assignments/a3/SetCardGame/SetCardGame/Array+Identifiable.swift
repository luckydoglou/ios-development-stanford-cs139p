//
//  Array+Identifiable.swift
//  SetCardGame
//
//  Created by Lor Worwag on 9/4/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable{
    func firstIndex(matching: Element) -> Int? {
        for index in self.indices {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
