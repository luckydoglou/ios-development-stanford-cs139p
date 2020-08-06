//
//  Array+Only.swift
//  a2
//
//  Created by Lor Worwag on 8/5/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
