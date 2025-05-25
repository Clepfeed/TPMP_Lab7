//
//  ViewController.swift
//  task2-2
//
//   
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var drawingView: DrawingView!
    
    
    @IBOutlet weak var animationSelector: UISegmentedControl!
    @IBAction func shapeChanged(_ sender: UISegmentedControl) {
        if let selected = ShapeType(rawValue: sender.selectedSegmentIndex) {
                    drawingView.shapeType = selected
                }
    }
    
    @IBAction func styleChanged(_ sender: UISegmentedControl) {
        if let selected = FillStyle(rawValue: sender.selectedSegmentIndex) {
                    drawingView.fillStyle = selected
                }
        drawingView.applyFillStyle()
        
    }
    
    
    @IBAction func applyAnimation(_ sender: Any) {
        if let selected = AnimationType(rawValue: animationSelector.selectedSegmentIndex) {
            drawingView.applyAnimation(type: selected)
        }
    }
    
    
    @IBAction func tap(_ sender: Any) {
        print("tapped")
        drawingView.applyTriangleBackground(named: "bg1")
        print("called func")
        

    }
    
    @IBAction func pinch(_ sender: Any) {
        drawingView.applyTriangleBackground(named: "bg2")
        

    }
    
    @IBAction func rotate(_ sender: Any) {
        drawingView.applyTriangleBackground(named: "bg3")

    }
    @IBAction func swipe(_ sender: Any) {
        drawingView.applyTriangleBackground(named: "bg4")

    }
    
    @IBAction func long_press(_ sender: Any) {
        drawingView.applyTriangleBackground(named: "bg5")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawingView.shapeType = .triangle
        drawingView.fillStyle = .solid
    }


}

