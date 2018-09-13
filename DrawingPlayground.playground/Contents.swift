//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

enum FillType {
    case stripe, solid, none
}

extension CGRect {
    func percentMaxX(_ percent: CGFloat) -> CGFloat {
        return self.maxX * percent
    }
    
    func percentMaxY(_ percent: CGFloat) -> CGFloat {
        return self.maxY * percent
    }
}

class SquiggleView: UIView {
    private var isStriped = false
    private var isSolid = false
    private var lineColor: UIColor
    
    init(frame: CGRect, fill: FillType, color: UIColor) {
        lineColor = color
        switch(fill) {
            case .stripe:
                isStriped = true
            case .solid:
                isSolid = true
            case .none:
                break
        }
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawStripes(bounds: CGRect, with color: UIColor) {
        for x in stride(from: 0.1, to: 1, by: 0.1) {
            let line = UIBezierPath()
            line.lineWidth = bounds.percentMaxX(0.05)
            line.move(to: CGPoint(x: bounds.percentMaxX(CGFloat(x)), y: bounds.minY))
            line.addLine(to: CGPoint(x: bounds.percentMaxX(CGFloat(x)), y: bounds.maxY))
            color.setStroke()
            line.stroke()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.percentMaxX(0.2), y: rect.percentMaxY(0.1)))
        path.addCurve(to: CGPoint(x: rect.percentMaxX(0.8), y: rect.percentMaxY(0.1)), controlPoint1: CGPoint(x: rect.percentMaxX(0.3), y: rect.percentMaxY(0)), controlPoint2: CGPoint(x: rect.percentMaxX(0.7), y: rect.percentMaxY(0.7)))
        path.addQuadCurve(to: CGPoint(x: rect.percentMaxX(0.8), y: rect.percentMaxY(0.9)), controlPoint: CGPoint(x: rect.maxX, y: rect.percentMaxY(0.5)))
        path.addCurve(to: CGPoint(x: rect.percentMaxX(0.2), y: rect.percentMaxY(0.9)), controlPoint1: CGPoint(x: rect.percentMaxX(0.7), y: rect.maxY), controlPoint2: CGPoint(x: rect.percentMaxX(0.3), y: rect.percentMaxY(0.3)))
        path.addQuadCurve(to: CGPoint(x: rect.percentMaxX(0.2), y: rect.percentMaxY(0.1)), controlPoint: CGPoint(x: rect.minX, y: rect.percentMaxY(0.5)))
        path.close()
        path.addClip()
        
        if isStriped {
            drawStripes(bounds: rect, with: lineColor)
        } else if isSolid {
            path.fill()
        }
        
        lineColor.setStroke()
        path.lineWidth = rect.percentMaxX(0.02)
        
        path.stroke()
    }
}

let view = SquiggleView(frame: CGRect(x: 0, y: 0, width: 300, height: 100), fill: .stripe, color: UIColor(red: 1, green: 0, blue: 0, alpha: 1))
view.backgroundColor = UIColor.white

PlaygroundPage.current.liveView = view
