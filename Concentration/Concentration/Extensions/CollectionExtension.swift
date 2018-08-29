//
//  CollectionExtension.swift
//  Concentration
//
//  Created by Timothy West on 8/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

extension Collection {
    /// Determines whether the collection contains one and only one element.
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
