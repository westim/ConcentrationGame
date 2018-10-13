//
//  ClaimTurnButton.swift
//  GraphicalSet
//
//  Created by Timothy West on 10/12/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class ClaimTurnButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor.yellow.cgColor
            } else {
                layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    private func setupButton() {
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.clear.cgColor
    }
}
