//
//  ViewController.swift
//  7.14_CoreMotion
//
//  Created by 王卓 on 15/4/17.
//  Copyright (c) 2015年 王卓. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController,UIAccelerometerDelegate {

    //required init(coder aDecoder: NSCoder) {
   //     fatalError("init(coder:) has not been implemented")
   // }

    var ball:UIImageView!;
    var speedX:UIAccelerationValue=0
    var speedY:UIAccelerationValue=0
    var motionManager = CMMotionManager()
    var target:UIImageView!
    
    
    //@IBOutlet 
    var label:UILabel!;
    var wincount=0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        target=UIImageView(image: UIImage(named: "Target"))
        target.frame=CGRectMake(160, 300, 50, 50)
        self.view.addSubview(target)
        label=UILabel();
        label.frame=CGRectMake(0, 0, 300, 50)
        label.center=self.view.center
        self.view.addSubview(label)
        
        
        ball=UIImageView(image: UIImage(named: "Ball"))
        //ball.frame=CGRectMake(80, 120, 50, 50)
        ball.frame=CGRectMake(0, 0, 50, 50)
        ball.center=self.view.center
        self.view.addSubview(ball)
        
        motionManager.accelerometerUpdateInterval=1/60
        
        if(motionManager.accelerometerAvailable){
                var queue = NSOperationQueue.currentQueue()
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler:{(accelerrometerData:CMAccelerometerData!,error:NSError!)in
                self.speedX+=accelerrometerData.acceleration.x
                self.speedY+=accelerrometerData.acceleration.y
                var posX=self.ball.center.x+CGFloat(self.speedX)
                var posY=self.ball.center.y-CGFloat(self.speedY)
                
                self.label.text="坐标为X:\(posX)Y:\(posY)"
                if(self.ball.center.x>130&&self.ball.center.x<190&&self.ball.center.y>270&&self.ball.center.y<330){
                println("WIN\(self.wincount)")
                self.wincount++;
                }
                

                
                if posX<0{
                    posX=0
                    self.speedX *= -0.5
                }else if posX>self.view.bounds.size.width{
                    posX=self.view.bounds.size.width
                    self.speedX *= -0.5
                }
                if posY<0{
                    posY=0
                    self.speedY *= -0.5
                }else if posY>self.view.bounds.size.height{
                    posY=self.view.bounds.size.height
                    self.speedY *= -0.5
                }
                self.ball.center=CGPointMake(posX, posY)})
//                self.label.text="小球当前的坐标为X:\(posX)Y:\(posY)"
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

