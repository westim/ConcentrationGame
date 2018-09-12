//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

extension CGRect {
    func percentMaxX(percent: CGFloat) -> CGFloat {
        return self.maxX * percent
    }
    
    func percentMaxY(percent: CGFloat) -> CGFloat {
        return self.maxY * percent
    }
}

class SquiggleView: UIView {
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.percentMaxX(percent: 0.1), y: rect.percentMaxY(percent: 0.2)))
        path.addCurve(to: CGPoint(x: rect.percentMaxX(percent: 0.9), y: rect.percentMaxY(percent: 0.2)), controlPoint1: CGPoint(x: rect.percentMaxX(percent: 0.3), y: rect.percentMaxY(percent: 0)), controlPoint2: CGPoint(x: rect.percentMaxX(percent: 0.6), y: rect.percentMaxY(percent: 0.8)))
        path.addQuadCurve(to: CGPoint(x: rect.percentMaxX(percent: 0.9), y: rect.percentMaxY(percent: 0.9)), controlPoint: CGPoint(x: rect.maxX, y: rect.percentMaxY(percent: 0.5)))
        path.addCurve(to: CGPoint(x: rect.percentMaxX(percent: 0.1), y: rect.percentMaxY(percent: 0.9)), controlPoint1: CGPoint(x: rect.percentMaxX(percent: 0.3), y: rect.maxY), controlPoint2: CGPoint(x: rect.percentMaxX(percent: 0.6), y: rect.percentMaxY(percent: 0.8)))
//        path.addCurve(to: CGPoint(x: 100, y: 150), controlPoint1: CGPoint(x: 166, y: 175), controlPoint2: CGPoint(x: 133, y: 125))
//        path.addQuadCurve(to: CGPoint(x: 100, y: 100), controlPoint: CGPoint(x: 75, y: 125))
        path.close()
        path.stroke()
    }
}

let view = SquiggleView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
view.backgroundColor = UIColor.white

PlaygroundPage.current.liveView = view
