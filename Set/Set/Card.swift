//
//  Card.swift
//  Set
//
//  Created by Timothy West on 8/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

struct Card {
    let Attribute1: Variant
    let Attribute2: Variant
    let Attribute3: Variant
    let Attribute4: Variant
    
    init(Att1: Variant, Att2: Variant, Att3: Variant, Att4: Variant) {
        Attribute1 = Att1
        Attribute2 = Att2
        Attribute3 = Att3
        Attribute4 = Att4
    }
    
    enum Variant {
        case one
        case two
        case three
    }
}
