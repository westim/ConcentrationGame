//
//  Card.swift
//  Set
//
//  Created by Timothy West on 8/28/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import Foundation

struct Card {
    let Attribute1: Int
    let Attribute2: Int
    let Attribute3: Int
    let Attribute4: Int
    
    init(Att1: Int, Att2: Int, Att3: Int, Att4: Int) {
        let validRange = Range(0...2)
        if !validRange.contains(Att1) || !validRange.contains(Att2) || !validRange.contains(Att3) || !validRange.contains(Att4) {
            print("Invalid values!")
        }
        Attribute1 = Att1
        Attribute2 = Att2
        Attribute3 = Att3
        Attribute4 = Att4
    }
}
