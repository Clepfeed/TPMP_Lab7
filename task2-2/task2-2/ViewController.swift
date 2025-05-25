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
    }
    
    
    @IBAction func applyAnimation(_ sender: Any) {
        if let selected = AnimationType(rawValue: animationSelector.selectedSegmentIndex) {
            drawingView.applyAnimation(type: selected)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawingView.shapeType = .triangle
        drawingView.fillStyle = .solid
    }


}

