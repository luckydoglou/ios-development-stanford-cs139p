//
//  Array+Only.swift
//  a3-practice
//
//  Created by Lor Worwag on 9/2/20.
//  Copyright © 2020 Lor Worwag. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}
