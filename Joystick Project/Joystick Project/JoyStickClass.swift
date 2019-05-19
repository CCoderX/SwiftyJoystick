//
//  JoyStickClass.swift
//  Joystick Project
//
//  Created by Mohamed Taher on 5/8/19.
//  Copyright © 2019 Mohamed Taher. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
class JoyStickClass{
    private var view : UIView? , size : Int = 0 ,stickSize = 0 , center : CGPoint? ,   cirView : circleView? ,mainCirView : circleView?
    init(view : UIView , size : Int , stickSize : Int , pos : CGPoint ) {
        self.view = view
        self.size = size
        self.stickSize = stickSize
        center = pos
        center?.x -= CGFloat(size/2)
        center?.y -= CGFloat(size/2)
        let cirFrame  = CGRect(origin: pos, size: CGSize(width: size, height: size))
        mainCirView = circleView(frame: cirFrame)
        view.addSubview(mainCirView!)
        cirView = circleView(frame: CGRect(x:mainCirView!.center.x-CGFloat(stickSize/2), y: mainCirView!.center.y-CGFloat(stickSize/2), width: CGFloat(stickSize), height:CGFloat( stickSize)))
        view.addSubview(cirView!)
    }
    func appendGestureRecognizerToStick(gest : UIPanGestureRecognizer){
        cirView!.addGestureRecognizer(gest)
        //        mainCirView!.addGestureRecognizer(gest)
        
    }
    func move(gest : UIPanGestureRecognizer){
        let x : CGFloat = mainCirView!.center.x - gest.location(in: view!).x //+ CGFloat(stickSize )
        let y :CGFloat = mainCirView!.center.y - gest.location(in: view!).y //+ CGFloat(stickSize )
        let squareDiff = pow(x, 2)+pow(y, 2)
        
        let distance = sqrt(squareDiff)
        
        if gest.state == .changed {
            //            cirView!.setPosition(x: x, y:y)
            if Int(distance) <= size/2 {
                cirView!.setPosition(x: gest.location(in: view).x - CGFloat(stickSize/2), y:gest.location(in: view).y - CGFloat(stickSize/2))
            }
            else  {
                let angle = atan2(Float(y) , Float(x)) - 135
                let x_pos = cos(angle) * Float(size/2), y_pos = sin(angle) * Float(size/2)
                cirView!.setPosition(x: CGFloat(x_pos) + CGFloat(size) - CGFloat(stickSize/2), y: CGFloat(y_pos) + CGFloat(size) * 1.5 - CGFloat(stickSize/2))
            }
        }
       else{
            
            cirView!.setPosition(x: mainCirView!.center.x - CGFloat(stickSize/2), y: mainCirView!.center.y - CGFloat(stickSize/2))
            cirView!.layoutIfNeeded()
            cirView!.setNeedsUpdateConstraints()
            cirView!.setNeedsFocusUpdate()
            
           
        }
        
    }
    
    func getXposition() -> Int{
        return Int( mainCirView!.center.x - cirView!.center.x)
    }
    func getYposition() -> Int{
        return Int( mainCirView!.center.x - cirView!.center.x)
    }
    func setStickBgColor(color : UIColor){
        mainCirView?.setBackGroundColor(color: color)
        cirView?.setBackGroundColor(color: color)
    }
    func setStickColor(color : UIColor){
        cirView?.setColor(color: color)
    }
    
    class circleView: UIView {
        private var color = UIColor.red
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = UIColor.green
        }
        func setPosition(x : CGFloat , y : CGFloat){
            let width = super.frame.width
            super.frame = CGRect(x: x, y: y, width: width, height: width)
            
        }
        required init(coder aDecoder: NSCoder) {
            fatalError("error")
        }
        func setColor(color : UIColor){
            self.color = color
            color.set()
        }
        func setBackGroundColor(color : UIColor){
            self.backgroundColor = color
        }
        override func draw(_ rect: CGRect ) {
            // Get the Graphics Context
            if let context = UIGraphicsGetCurrentContext() {
                
                // Set the circle outerline-width
                context.setLineWidth(5.0);
                
                // Set the circle outerline-colour
                self.color.set()
                let radius = (frame.size.width )/2
                // Create Circle
                let center = CGPoint(x: (frame.size.width/2), y: (frame.size.height/2))
                context.addArc(center: center, radius: radius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
                
                //
                // Draw
                context.strokePath()
            }
        }
    }
}


