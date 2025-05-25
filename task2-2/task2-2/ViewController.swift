//
//  ViewController.swift
//  task2-2
//
//   
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var drawingView: DrawingView!
    
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawingView.shapeType = .triangle
        drawingView.fillStyle = .solid
    }


}

