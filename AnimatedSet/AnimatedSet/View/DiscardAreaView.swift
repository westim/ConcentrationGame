//
//  DiscardAreaView.swift
//  AnimatedSet
//
//  Created by Timothy West on 2/12/19.
//  Copyright © 2019 Tim West. All rights reserved.
//

import UIKit

@IBDesignable
class DiscardAreaView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        layer.borderWidth = 5.0
        layer.cornerRadius = 3.0
        layer.backgroundColor = UIColor.clear.cgColor
        layer.borderColor = UIColor.red.cgColor
    }
}
