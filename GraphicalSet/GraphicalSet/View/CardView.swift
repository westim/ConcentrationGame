//
//  CardView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/21/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIButton {
    
    func setup<T: SetSymbolView>(symbol: T, count: Int, fill: T.FillType) {
        self.layer.cornerRadius = self.bounds.width / 4
        self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
