//
//  Array+repeating.swift
//  GraphicalSet
//
//  Created by Timothy West on 10/4/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

extension Array {
    /**
     Creates an Array of Element by calling the
     constructor `count` times.
     
     Shamelessly pulled from StackOverflow:
     https://stackoverflow.com/a/32921506
     */
    public init(count: Int, elementCreator: @autoclosure () -> Element) {
        self = (0 ..< count).map { _ in elementCreator() }
    }
}
