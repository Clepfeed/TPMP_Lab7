//
//  UIBezierPath+Shapes.swift
//  task2-2
//
//   
//

import UIKit

extension UIBezierPath {
    static func curvedTriangle(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let left = CGPoint(x: rect.minX, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.maxY)

        path.move(to: top)
        path.addQuadCurve(to: left, controlPoint: CGPoint(x: rect.minX - 40, y: rect.midY))
        path.addQuadCurve(to: right, controlPoint: CGPoint(x: rect.midX, y: rect.maxY + 40))
        path.addQuadCurve(to: top, controlPoint: CGPoint(x: rect.maxX + 40, y: rect.midY))
        path.close()

        return path
    }

    static func hexagon(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let side = min(rect.width, rect.height)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = side / 2

        for i in 0..<6 {
            let angle = CGFloat(i) * CGFloat.pi / 3
            let point = CGPoint(x: center.x + radius * cos(angle),
                                y: center.y + radius * sin(angle))
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.close()
        return path
    }

    static func unionPath(_ first: UIBezierPath, _ second: UIBezierPath) -> UIBezierPath {
        let path = UIBezierPath()
        path.append(first)
        path.append(second)
        return path
    }

    static func subtractPath(_ first: UIBezierPath, _ second: UIBezierPath) -> UIBezierPath {
        let shape = CGMutablePath()
        shape.addPath(first.cgPath)
        let subtractPath = second.cgPath.copy(using: nil)!

        let combined = shape.mutableCopy()
        combined?.addPath(subtractPath)
        let result = UIBezierPath(cgPath: combined!)
        return result
    }
}

