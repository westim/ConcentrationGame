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
            line.lineWidth = bounds.percentMaxX(0.05)
            line.move(to: CGPoint(x: bounds.percentMaxX(CGFloat(x)), y: bounds.minY))
            line.addLine(to: CGPoint(x: bounds.percentMaxX(CGFloat(x)), y: bounds.maxY))
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
        path.lineWidth = rect.percentMaxX(0.02)
        
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
        path.move(to: CGPoint(x: rect.percentMaxX(0.5), y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.percentMaxY(0.5)))
        path.addLine(to: CGPoint(x: rect.percentMaxX(0.5), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.percentMaxY(0.5)))
        path.close()
        path.addClip()
        
        if super.isStriped {
            super.drawStripes(bounds: rect, with: super.lineColor)
        } else if super.isSolid {
            super.lineColor.setFill()
            path.fill()
        }
        
        super.lineColor.setStroke()
        path.lineWidth = rect.percentMaxX(0.02)
        
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
        path.move(to: CGPoint(x: rect.percentMaxX(0.1), y: rect.percentMaxY(0.05)))
        path.addCurve(to: CGPoint(x: rect.percentMaxX(0.9), y: rect.percentMaxY(0.05)), controlPoint1: CGPoint(x: rect.percentMaxX(0.3), y: rect.percentMaxY(0)), controlPoint2: CGPoint(x: rect.percentMaxX(0.7), y: rect.percentMaxY(0.7)))
        path.addQuadCurve(to: CGPoint(x: rect.percentMaxX(0.9), y: rect.percentMaxY(0.95)), controlPoint: CGPoint(x: rect.percentMaxX(1.1), y: rect.percentMaxY(0.5)))
        path.addCurve(to: CGPoint(x: rect.percentMaxX(0.1), y: rect.percentMaxY(0.95)), controlPoint1: CGPoint(x: rect.percentMaxX(0.7), y: rect.maxY), controlPoint2: CGPoint(x: rect.percentMaxX(0.3), y: rect.percentMaxY(0.3)))
        path.addQuadCurve(to: CGPoint(x: rect.percentMaxX(0.1), y: rect.percentMaxY(0.05)), controlPoint: CGPoint(x: rect.percentMaxX(-0.1), y: rect.percentMaxY(0.5)))
        path.close()
        path.addClip()
        
        if super.isStriped {
            super.drawStripes(bounds: rect, with: super.lineColor)
        } else if super.isSolid {
            super.lineColor.setFill()
            path.fill()
        }
        
        super.lineColor.setStroke()
        path.lineWidth = rect.percentMaxX(0.02)
        
        path.stroke()
    }
}

let view = OvalView(frame: CGRect(x: 0, y: 0, width: 600, height: 300), fill: .stripe, color: UIColor(red: 0, green: 1, blue: 0, alpha: 1))
view.backgroundColor = UIColor.white

PlaygroundPage.current.liveView = view
