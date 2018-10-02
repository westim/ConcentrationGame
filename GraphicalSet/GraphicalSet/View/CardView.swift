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
    var color = UIColor.black { didSet { refreshSymbols() } }
    var fill = SetSymbolView.FillType.none { didSet { refreshSymbols() } }
    var symbol = SetSymbolView.self { didSet { refreshSymbols() } }
    
    override var isSelected: Bool { didSet { changeBorder(); setNeedsDisplay() } }
    var isMatching: Bool? = nil { didSet { changeBackgroundColor(); setNeedsDisplay() } }
    var isHinted: Bool = false { didSet { changeBorder(); setNeedsDisplay() } }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.center = self.bounds.center
        self.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.sizeThatFits(self.symbolAreaSize)
        return stackView
    }()
    
    private func setup() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        changeBackgroundColor()
    }
    
    private func refreshSymbols() {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        for _ in 0..<count {
            stackView.addSubview(symbol.init(frame: stackView.bounds, fill: fill, color: color))
        }
        stackView.setNeedsDisplay()
        stackView.setNeedsLayout()
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
        guard let match = isMatching else { self.layer.backgroundColor = Colors.background.cgColor; return }
        self.layer.backgroundColor = match ? Colors.matchingSet.cgColor : Colors.mismatchingSet.cgColor
    }
}

// MARK: Constants

private extension CardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let symbolSizeToBoundsWidthSize: CGFloat = 0.8
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
        let side = bounds.size.width * SizeRatio.symbolSizeToBoundsWidthSize
        return CGSize(width: side, height: side)
    }
}
