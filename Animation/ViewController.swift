//
//  ViewController.swift
//  Animation
//
//  Created by Mac on 2017/2/26.
//  Copyright © 2017年 shibiao. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var horse: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func move(_ sender: NSButton) {
        //添加动画
        addAnimations()
    }
    func addAnimations() {
       self.horse.translatesAutoresizingMaskIntoConstraints = false
        NSAnimationContext.runAnimationGroup({ (context) in
            self.horse.removeConstraints([top,trailing])
            //动画间隔
            context.duration = 2
            //动画运动模式，easeOut，缓出
            let timingFunc = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            context.timingFunction = timingFunc
            //设置初始点坐标
            self.horse.animator().setFrameOrigin(NSMakePoint(0, 0))
            //设置透明度
            self.horse.animator().alphaValue = 0.4
            
        }) {
            
            NSAnimationContext.runAnimationGroup({ (context) in
                context.duration = 2
                //使之前的约束失效
                self.disableOldConstraint()
                self.horse.animator().alphaValue = 1.0
                self.horse.animator().setFrameSize(NSMakeSize(200, 200))
                self.horse.animator().setFrameOrigin(NSMakePoint(100, 100))
                Swift.print(self.horse.frame)
                
            }, completionHandler: {
                //动画结束后重新约束图片的位置
                self.addHorseConstraint()
            })
        }
    }
    //使之前的约束失效
    func disableOldConstraint() {
        self.horse.translatesAutoresizingMaskIntoConstraints = true
        self.top.animator().isActive = false
        self.trailing.animator().isActive = false
        self.height.animator().isActive = false
        self.width.animator().isActive = false
        
    }
    //动画结束后重新约束图片的位置
    func addHorseConstraint() {
        self.horse.translatesAutoresizingMaskIntoConstraints = false
        self.horse.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.horse.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.horse.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100).isActive = true
        self.horse.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

