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
    
    func setup() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = Colors.selectedBorder
        clipsToBounds = true
        changeBackgroundColor()
        createSymbols()
    }
    
    private func createSymbols() {
        switch count {
        case 1:
            let firstSymbol = symbol.init(frame: CGRect(origin: symbolOrigin, size: symbolSize), fill: fill, color: color)
            addSubview(firstSymbol)
        case 2:
            let firstSymbol = symbol.init(frame: CGRect(origin: symbolOrigin, size: symbolSize), fill: fill, color: color)
            let secondSymbol = symbol.init(frame: CGRect(origin: symbolOrigin, size: symbolSize), fill: fill, color: color)
            firstSymbol.transform = CGAffineTransform(translationX: 0, y: twoSymbolOffset)
            secondSymbol.transform = CGAffineTransform(translationX: 0, y: -twoSymbolOffset)
            addSubview(firstSymbol)
            addSubview(secondSymbol)
        case 3:
            let firstSymbol = symbol.init(frame: CGRect(origin: symbolOrigin, size: symbolSize), fill: fill, color: color)
            let secondSymbol = symbol.init(frame: CGRect(origin: symbolOrigin, size: symbolSize), fill: fill, color: color)
            let thirdSymbol = symbol.init(frame: CGRect(origin: symbolOrigin, size: symbolSize), fill: fill, color: color)
            secondSymbol.transform = CGAffineTransform(translationX: 0, y: threeSymbolOffset)
            thirdSymbol.transform = CGAffineTransform(translationX: 0, y: -threeSymbolOffset)
            addSubview(firstSymbol)
            addSubview(secondSymbol)
            addSubview(thirdSymbol)
        default:
            print("Invalid symbol count: \(count)")
        }
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
            layer.borderColor = Colors.selectedBorder
        } else if isHinted {
            layer.borderColor = Colors.hintedBorder
        } else {
            layer.borderColor = Colors.transparentBorder
        }
    }
    
    private func changeBackgroundColor() {
        guard let match = isMatching else { swapToColor(withDuration: Timing.animationDuration, toColor: Colors.background); return }
        let matchColor = match ? Colors.matchingSet : Colors.mismatchingSet
        swapToColor(withDuration: Timing.animationDuration, toColor: matchColor)
    }
}

// MARK: Constants

private extension CardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.05
        static let symbolWidthSizeToBoundsWidthSize: CGFloat = 0.8
        static let symbolHeightSizeToBoundsHeightSize: CGFloat = 0.3
        static let borderSize: CGFloat = 0.03
    }
    
    private struct Timing {
        static let animationDuration: Double = 0.3
    }
    
    private struct Colors {
        static let background = UIColor.black
        static let matchingSet = UIColor.lightGreen
        static let mismatchingSet = UIColor.lightRed
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
    
    private var symbolSize: CGSize {
        let height = bounds.height * SizeRatio.symbolHeightSizeToBoundsHeightSize
        let width = bounds.width * SizeRatio.symbolWidthSizeToBoundsWidthSize
        return CGSize(width: width, height: height)
    }
    
    private var twoSymbolOffset: CGFloat {
        return symbolSize.height * 0.51
    }
    
    private var threeSymbolOffset: CGFloat {
        return symbolSize.height * 1.02
    }
    
    private var symbolOrigin: CGPoint {
        let x = bounds.center.x - symbolSize.width / 2
        let y = bounds.center.y - symbolSize.height / 2
        return CGPoint(x: x, y: y)
    }
}
