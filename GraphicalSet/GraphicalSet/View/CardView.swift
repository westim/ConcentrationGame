//
//  CardView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/21/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIButton {
    
    var count = 0
    var color = UIColor.black
    var fill = SetSymbolView.FillType.none
    var symbol = SetSymbolView.self
    
    override var isSelected: Bool { didSet { changeBorder(); setNeedsDisplay() } }
    var isMatchingSet: Bool? = nil { didSet { changeBackgroundColor(); setNeedsDisplay() } }
    var isHinted: Bool = false { didSet { changeBorder(); setNeedsDisplay() } }
    
    private func setup() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        changeBackgroundColor()
        
        let stackView = UIStackView()
        for _ in 1...count {
            stackView.addSubview(symbol.init(frame: stackView.bounds, fill: fill, color: color))
        }
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.sizeThatFits(self.symbolAreaSize)
        stackView.center = self.bounds.center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func changeBorder() {
        if isSelected {
            self.layer.borderColor = UIColor.yellow.cgColor
        } else if isHinted {
            self.layer.borderColor = UIColor.green.cgColor
        } else {
            self.layer.borderColor = UIColor.transparent.cgColor
        }
    }
    
    private func changeBackgroundColor() {
        guard let matching = isMatchingSet else { self.layer.backgroundColor = Colors.background.cgColor; return }
        self.layer.backgroundColor = matching ? Colors.matchingSet.cgColor : Colors.mismatchingSet.cgColor
    }
}

// MARK: Constants

private extension CardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let symbolSizeToBoundsSize: CGFloat = 0.8
        static let borderSize: CGFloat = 0.05
    }
    
    private struct Colors {
        static let background = UIColor.black
        static let matchingSet = UIColor.lightGreen
        static let mismatchingSet = UIColor.lightRed
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var borderWidth: CGFloat {
        return bounds.size.height * SizeRatio.borderSize
    }
    
    private var symbolAreaSize: CGSize {
        let side = bounds.size.width * SizeRatio.symbolSizeToBoundsSize
        return CGSize(width: side, height: side)
    }
}
