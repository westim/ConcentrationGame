//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

enum FillType {
    case stripe, solid, none
}

extension CGRect {
    /**
     Gets a point as a percentage of `maxX` and `maxY`.
     
     - Parameter x: Percent of `maxX`.
     - Parameter y: Percent of `maxY`.
     
     - Return: Point in the rect.
    */
    func getPoint(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.maxX * x, y: self.maxY * y)
    }
}

class SetSymbol: UIView {
    var isStriped = false
    var isSolid = false
    var lineColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
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
    
    func drawStripes(bounds: CGRect, with color: UIColor) {
        for x in stride(from: 0, to: 1, by: 0.1) {
            let line = UIBezierPath()
            line.lineWidth = 0.05 * bounds.maxX
            line.move(to: bounds.getPoint(x: CGFloat(x), y: 0))
            line.addLine(to: bounds.getPoint(x: CGFloat(x), y: 1))
            color.setStroke()
            line.stroke()
        }
    }
}

class OvalView: SetSymbol {
    
    override init(frame: CGRect, fill: FillType, color: UIColor) {
        super.init(frame: frame, fill: fill, color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2)
        path.addClip()
        
        if super.isStriped {
            super.drawStripes(bounds: rect, with: super.lineColor)
        } else if super.isSolid {
            super.lineColor.setFill()
            path.fill()
        }
        
        super.lineColor.setStroke()
        path.lineWidth = 0.02 * rect.maxX
        
        path.stroke()
    }
}

class DiamondView: SetSymbol {
    
    override init(frame: CGRect, fill: FillType, color: UIColor) {
        super.init(frame: frame, fill: fill, color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {

        let path = UIBezierPath()
        path.move(to: rect.getPoint(x: 0.5, y: 0))
        path.addLine(to: rect.getPoint(x: 1, y: 0.5))
        path.addLine(to: rect.getPoint(x: 0.5, y: 1))
        path.addLine(to: rect.getPoint(x: 0, y: 0.5))
        path.close()
        path.addClip()
        
        if super.isStriped {
            super.drawStripes(bounds: rect, with: super.lineColor)
        } else if super.isSolid {
            super.lineColor.setFill()
            path.fill()
        }
        
        super.lineColor.setStroke()
        path.lineWidth = 0.02 * rect.maxX
        
        path.stroke()
    }
}

class SquiggleView: SetSymbol {
    
    override init(frame: CGRect, fill: FillType, color: UIColor) {
        super.init(frame: frame, fill: fill, color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: rect.getPoint(x: 0.2, y: 0.05))
        path.addCurve(to: rect.getPoint(x: 0.7, y: 0.2), controlPoint1: rect.getPoint(x: 0.3, y: 0), controlPoint2: rect.getPoint(x: 0.5, y: 0.2))
        path.addCurve(to: rect.getPoint(x: 0.95, y: 0.15), controlPoint1: rect.getPoint(x: 0.8, y: 0.2), controlPoint2: rect.getPoint(x: 0.9, y: -0.1))
        path.addCurve(to: rect.getPoint(x: 0.8, y: 0.95), controlPoint1: rect.getPoint(x: 1.05, y: 0.6), controlPoint2: rect.getPoint(x: 0.9, y: 0.9))
        
        path.addCurve(to: rect.getPoint(x: 0.3, y: 0.8), controlPoint1: rect.getPoint(x: 0.7, y: 1), controlPoint2: rect.getPoint(x: 0.5, y: 0.8))
        path.addCurve(to: rect.getPoint(x: 0.05, y: 0.85), controlPoint1: rect.getPoint(x: 0.2, y: 0.8), controlPoint2: rect.getPoint(x: 0.1, y: 1.1))
        path.addCurve(to: rect.getPoint(x: 0.2, y: 0.05), controlPoint1: rect.getPoint(x: -0.05, y: 0.4), controlPoint2: rect.getPoint(x: 0.1, y: 0.1))
        path.close()
        path.addClip()

        if super.isStriped {
            super.drawStripes(bounds: rect, with: super.lineColor)
        } else if super.isSolid {
            super.lineColor.setFill()
            path.fill()
        }
        
        super.lineColor.setStroke()
        path.lineWidth = 0.02 * rect.maxX
        path.lineJoinStyle = .round
        path.stroke()
    }
}

let view = SquiggleView(frame: CGRect(x: 0, y: 0, width: 600, height: 300), fill: .stripe, color: UIColor(red: 0, green: 1, blue: 0, alpha: 1))
view.backgroundColor = UIColor.white

PlaygroundPage.current.liveView = view
