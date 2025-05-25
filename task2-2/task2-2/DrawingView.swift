//
//  DrawingView.swift
//  task2-2
//
//   
//

	
import UIKit

class DrawingView: UIView {

    var shapeType: ShapeType = .triangle {
        didSet { setNeedsDisplay() }
    }

    var fillStyle: FillStyle = .solid {
        didSet { setNeedsDisplay() }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let insetRect = rect.insetBy(dx: 20, dy: 20)
        let triangle = UIBezierPath.curvedTriangle(in: insetRect)
        let hexagon = UIBezierPath.hexagon(in: insetRect)

        var path: UIBezierPath

        switch shapeType {
        case .triangle:
            path = triangle
        case .hexagon:
            path = hexagon
        case .union:
            path = .unionPath(triangle, hexagon)
        case .subtract:
            path = .subtractPath(triangle, hexagon)
        }

        switch fillStyle {
        case .solid:
            UIColor.systemBlue.setFill()
            path.fill()
        case .gradient:
            context.saveGState()
            path.addClip()
            let colors = [UIColor.systemPurple.cgColor, UIColor.systemTeal.cgColor] as CFArray
            let space = CGColorSpaceCreateDeviceRGB()
            if let gradient = CGGradient(colorsSpace: space, colors: colors, locations: [0, 1]) {
                context.drawLinearGradient(gradient,
                                           start: CGPoint(x: rect.minX, y: rect.minY),
                                           end: CGPoint(x: rect.maxX, y: rect.maxY),
                                           options: [])
            }
            context.restoreGState()
        case .shadow:
            context.saveGState()
            context.setShadow(offset: CGSize(width: 5, height: 5), blur: 10, color: UIColor.black.withAlphaComponent(0.5).cgColor)
            UIColor.systemGreen.setFill()
            path.fill()
            context.restoreGState()
        }
    }
}

