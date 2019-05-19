//
//  ViewController.swift
//  Joystick Project
//
//  Created by Mohamed Taher on 5/8/19.
//  Copyright © 2019 Mohamed Taher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var stick : JoyStickClass? , label : UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        stick = JoyStickClass(view: view, size: Int(view.frame.width/2), stickSize: Int(50), pos: CGPoint(x: view.frame.width/4, y: view.frame.height/4))
        stick?.setStickColor(color: .blue)
        stick?.setStickBgColor(color: .yellow)
        view.backgroundColor = .yellow
        let panGest = UIPanGestureRecognizer(target: self, action: #selector(drawJoystick(gest:)))
        stick!.appendGestureRecognizerToStick(gest: panGest)
        label = UILabel(frame: CGRect(x: view.frame.width/4 , y: view.frame.height/4 + 200 , width: 200, height: 100))
        
        view.addSubview(label!)
    }
    @objc func drawJoystick(gest : UIPanGestureRecognizer) {
        stick?.move(gest: gest)
        label?.text = "X =   " + String(stick!.getXposition() ) + "  Y = " + String(stick!.getYposition() )
    }
}

