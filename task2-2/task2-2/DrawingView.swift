//
//  DrawingView.swift
//  task2-2
//
//   
//

	
import UIKit

enum AnimationType: Int {
    case move
    case rotate
    case scale
    case fade
    case moveAndRotate
}

class DrawingView: UIView {

    var shapeType: ShapeType = .triangle {
        didSet { redraw() }
    }

    var fillStyle: FillStyle = .solid {
        didSet { redraw() }
    }

    private let shapeLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.addSublayer(shapeLayer)
        shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        redraw()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        redraw()
    }

    private func redraw() {
        let boundsRect = bounds.insetBy(dx: 40, dy: 40)

        // Уменьшенный треугольник
        let shapeRect: CGRect
        if shapeType != .hexagon {
            shapeRect = boundsRect.insetBy(dx: boundsRect.width * 0.25, dy: boundsRect.height * 0.25)
        } else {
            shapeRect = boundsRect
        }

        let triangle = UIBezierPath.curvedTriangle(in: shapeRect)
        let hexagon = UIBezierPath.hexagon(in: shapeRect)

        var path: UIBezierPath

        switch shapeType {
        case .triangle:
            path = triangle
        case .hexagon:
            path = hexagon
        case .union:
            path = UIBezierPath()
            path.append(triangle)
            path.append(hexagon)
            path.usesEvenOddFillRule = false
        case .subtract:
            path = UIBezierPath()
            path.append(triangle)
            path.append(hexagon)
            path.usesEvenOddFillRule = true
        }

        shapeLayer.path = path.cgPath
        shapeLayer.fillRule = path.usesEvenOddFillRule ? .evenOdd : .nonZero

        applyFillStyle()
    }

    private func applyFillStyle() {
        shapeLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
        shapeLayer.shadowOpacity = 0
        shapeLayer.opacity = 1.0
        shapeLayer.transform = CATransform3DIdentity

        switch fillStyle {
        case .solid:
            shapeLayer.fillColor = UIColor.systemBlue.cgColor
        case .gradient:
            let gradient = CAGradientLayer()
            gradient.frame = bounds
            gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemTeal.cgColor]
            gradient.mask = shapeLayer
            layer.addSublayer(gradient)
        case .shadow:
            shapeLayer.fillColor = UIColor.systemGreen.cgColor
            shapeLayer.shadowColor = UIColor.black.cgColor
            shapeLayer.shadowOffset = CGSize(width: 5, height: 5)
            shapeLayer.shadowRadius = 8
            shapeLayer.shadowOpacity = 0.5
        }
    }

    // MARK: - Анимации

    func applyAnimation(type: AnimationType) {
        shapeLayer.removeAllAnimations()

        switch type {
        case .move:
            let anim = CABasicAnimation(keyPath: "position")
            anim.fromValue = shapeLayer.position
            anim.toValue = CGPoint(x: shapeLayer.position.x + 80, y: shapeLayer.position.y)
            anim.duration = 1.0
            anim.autoreverses = true
            shapeLayer.add(anim, forKey: "position")
        case .rotate:
            let anim = CABasicAnimation(keyPath: "transform.rotation")
            anim.toValue = CGFloat.pi
            anim.duration = 1.0
            anim.autoreverses = true
            shapeLayer.add(anim, forKey: "rotation")
        case .scale:
            let anim = CABasicAnimation(keyPath: "transform.scale")
            anim.fromValue = 1.0
            anim.toValue = 1.5
            anim.duration = 1.0
            anim.autoreverses = true
            shapeLayer.add(anim, forKey: "scale")
        case .fade:
            let anim = CABasicAnimation(keyPath: "opacity")
            anim.fromValue = 1.0
            anim.toValue = 0.2
            anim.duration = 1.0
            anim.autoreverses = true
            shapeLayer.add(anim, forKey: "opacity")
        case .moveAndRotate:
            let move = CABasicAnimation(keyPath: "position")
            move.toValue = CGPoint(x: shapeLayer.position.x + 60, y: shapeLayer.position.y + 40)

            let rotate = CABasicAnimation(keyPath: "transform.rotation")
            rotate.toValue = CGFloat.pi

            let group = CAAnimationGroup()
            group.animations = [move, rotate]
            group.duration = 1.2
            group.autoreverses = true

            shapeLayer.add(group, forKey: "moveAndRotate")
        }
    }
}
