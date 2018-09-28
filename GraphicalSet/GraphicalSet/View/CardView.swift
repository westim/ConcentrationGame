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
    var color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    var fill = SetSymbolView.FillType.none
    var symbol = SetSymbolView.self
    
    override var isSelected: Bool { didSet { changeBorder() } }
    
    private func setup() {
        let stackView = UIStackView()
        for _ in 1...count {
            stackView.addSubview(symbol.init(frame: stackView.bounds, fill: fill, color: color))
        }
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.sizeThatFits(self.symbolAreaSize)
        stackView.center = self.bounds.center
        self.layer.borderColor = Colors.borderColor
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
        self.layer.borderColor = isSelected ? Colors.borderColor : Colors.transparentColor
    }
}

// MARK: Constants

extension CardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let symbolSizeToBoundsSize: CGFloat = 0.8
    }
    
    private struct Colors {
        static let borderColor: CGColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1).cgColor
        static let transparentColor: CGColor = UIColor(red: 1, green: 1, blue: 0, alpha: 0).cgColor
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var symbolAreaSize: CGSize {
        let side = bounds.size.width * SizeRatio.symbolSizeToBoundsSize
        return CGSize(width: side, height: side)
    }
}
