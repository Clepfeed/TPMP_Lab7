//
//  ViewController.swift
//  example2
//
//   
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var gestureIndicator: UILabel!
    @IBAction func tap(sender: AnyObject)
     {
         gestureIndicator.text = "Жест: касание\n Цвет фона: зеленый"
         gestureIndicator.backgroundColor = UIColor.green
     }
     @IBAction func pinch(sender: AnyObject)
     {
         gestureIndicator.text = "Жест: масштабирование\n Цвет фона: красный"
          gestureIndicator.backgroundColor = UIColor.red
     }
     @IBAction func rotation(sender: AnyObject)
     {
         gestureIndicator.text = "Жест: вращение\n Цвет фона: синий"
         gestureIndicator.backgroundColor = UIColor.blue
     }
     @IBAction func swipe(sender: AnyObject)
     {
         gestureIndicator.text = "Жест: смахивание\n Цвет фона: серый"
         gestureIndicator.backgroundColor = UIColor.lightGray
     }

     @IBAction func longPress(sender: AnyObject)
     {
         gestureIndicator.text = "Жест: долгое нажатие\n Цвет фона: оранжевый"
         gestureIndicator.backgroundColor = UIColor.orange
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureIndicator.isUserInteractionEnabled = true
        gestureIndicator.textAlignment = NSTextAlignment.center
        gestureIndicator.numberOfLines = 2
        gestureIndicator.text = "Используйте жесты в этой области"
        gestureIndicator.backgroundColor = UIColor.yellow
        
    }


}

