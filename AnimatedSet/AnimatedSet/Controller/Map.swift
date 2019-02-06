//
//  CardMap.swift
//  AnimatedSet
//
//  Created by Timothy West on 2/5/19.
//  Copyright © 2019 Tim West. All rights reserved.
//

import UIKit

/// Maps the Card properties to UI values.
struct Map {
    static let symbols = [
        Card.Variant.one: SquiggleView.self,
        Card.Variant.two: DiamondView.self,
        Card.Variant.three: OvalView.self
    ]
    static let counts = [
        Card.Variant.one: 1,
        Card.Variant.two: 2,
        Card.Variant.three: 3
    ]
    static let fills = [
        Card.Variant.one: SetSymbolView.FillType.none,
        Card.Variant.two: SetSymbolView.FillType.solid,
        Card.Variant.three: SetSymbolView.FillType.stripe
    ]
    static let colors = [
        Card.Variant.one: UIColor.cyan,
        Card.Variant.two: UIColor.magenta,
        Card.Variant.three: UIColor.yellow
    ]
}
