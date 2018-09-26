//
//  CardView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/21/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIButton {
    
    // TODO: Figure out if I actually need default values for these properties
    var count = 0
    var color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    var fill = SetSymbolView.FillType.none
    var symbol = SetSymbolView()
    
    private func setup() {
        // TODO: Provide values to the properties
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func addSymbols() {
        for _ in 0..<count {
            self.addSubview(SetSymbolView(frame: CGRect.zero, fill: fill, color: color))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // TODO: Layout the symbol views
    }    
}

// MARK: Constants

extension CardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let symbolSizeToBoundsSize: CGFloat = 0.2
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var symbolSize: CGFloat {
        return bounds.size.height * SizeRatio.symbolSizeToBoundsSize
    }
}
