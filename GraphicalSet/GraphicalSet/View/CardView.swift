//
//  CardView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/21/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIButton {
    
    var count: Int
    var color: UIColor
    var fill: SetSymbolView.FillType
    var symbol: SetSymbolView
    
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
