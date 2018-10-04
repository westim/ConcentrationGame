//
//  CardView.swift
//  GraphicalSet
//
//  Created by Timothy West on 9/21/18.
//  Copyright © 2018 Tim West. All rights reserved.
//

import UIKit

class CardView: UIButton {
    
    var count = 0
    var color = UIColor.black
    var fill = SetSymbolView.FillType.none
    var symbol = SetSymbolView.self
    
    override var isSelected: Bool { didSet { changeBorder() } }
    var isMatching: Bool? = nil { didSet { changeBackgroundColor() } }
    var isHinted: Bool = false { didSet { changeBorder() } }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.center = self.convert(self.center, from: stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.frame.size = self.symbolAreaSize
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    func setup() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = Colors.selectedBorder
        self.addSubview(stackView)
        clipsToBounds = true
        changeBackgroundColor()
        createSymbols()
    }
    
    private func createSymbols() {
        for _ in 0..<count {
            stackView.addArrangedSubview(symbol.init(frame: CGRect.zero, fill: fill, color: color))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(count: Int, color: UIColor, fill: SetSymbolView.FillType, symbol: SetSymbolView.Type) {
        self.init(frame: .zero)
        self.count = count
        self.color = color
        self.fill = fill
        self.symbol = symbol
    }
    
    private func changeBorder() {
        if isSelected {
            self.layer.borderColor = Colors.selectedBorder
        } else if isHinted {
            self.layer.borderColor = Colors.hintedBorder
        } else {
            self.layer.borderColor = Colors.transparentBorder
        }
    }
    
    private func changeBackgroundColor() {
        guard let match = isMatching else { self.layer.backgroundColor = Colors.background; return }
        self.layer.backgroundColor = match ? Colors.matchingSet : Colors.mismatchingSet
    }
}

// MARK: Constants

private extension CardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.05
        static let symbolSizeToBoundsWidthSize: CGFloat = 0.5
        static let borderSize: CGFloat = 0.03
    }
    
    private struct Colors {
        static let background = UIColor.black.cgColor
        static let matchingSet = UIColor.lightGreen.cgColor
        static let mismatchingSet = UIColor.lightRed.cgColor
        static let selectedBorder = UIColor.yellow.cgColor
        static let transparentBorder = UIColor.transparent.cgColor
        static let hintedBorder = UIColor.green.cgColor
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
