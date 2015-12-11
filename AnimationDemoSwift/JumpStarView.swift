//
//  JumpStarView.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/12/8.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

enum JumpStarState{
    case nonMark
    case Mark
}

class JumpStarView: UIView {
    let jumpDuration = 0.125
    let downDuration = 0.215
    var state: JumpStarState! {
        didSet {
            startView?.image = state == JumpStarState.Mark ? markImage:nonMarkImage;
        }
//        get {
//            return state
//        }
//        set(newValue) {
//            state = newValue
//            startView?.image = newValue == JumpStarState.Mark ? markImage:nonMarkImage;
//        }
    }
    var markImage: UIImage?
    var nonMarkImage: UIImage?
    private var startView: UIImageView?
    private var shadowView: UIImageView?
    var animating: Bool = false

   
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clearColor()
        if startView == nil {
            startView = UIImageView(frame: CGRectMake(self.bounds.size.width/2 - (self.bounds.size.width-6)/2, 0, self.bounds.size.width-6, self.bounds.size.height - 6))
            startView?.contentMode = .ScaleToFill
            self.addSubview(startView!)
        }
        if shadowView == nil {
            shadowView = UIImageView(frame: CGRectMake(self.bounds.size.width/2 - 10/2, self.bounds.size.height - 3, 10, 3))
            shadowView?.contentMode = .ScaleToFill
            shadowView?.alpha = 0.4
            shadowView?.image = UIImage(named: "shadow_new")
            self.addSubview(shadowView!)
        }
        
    }
    //跳起动画
    func animateSelf() {
        if animating {
            return
        }
        animating = true

        
        let transformAnima = CABasicAnimation(keyPath: "transform.rotation.y")
        transformAnima.delegate = self
        transformAnima.fromValue = 0
        transformAnima.toValue = M_PI_2
        transformAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let positionAnima = CABasicAnimation(keyPath: "position.y")
        positionAnima.fromValue = startView?.center.y
        positionAnima.toValue = (startView?.center.y)! - 14
        positionAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let animGroup = CAAnimationGroup()
        animGroup.duration = jumpDuration
        animGroup.fillMode = kCAFillModeForwards
        animGroup.delegate = self
        animGroup.removedOnCompletion = false
        animGroup.animations = [transformAnima,positionAnima]
        
        startView?.layer.addAnimation(animGroup, forKey: "jumpUp")
    }
    //下落动画
    
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if anim.isEqual(startView?.layer.animationForKey("jumpUp")) {
            state = state == JumpStarState.Mark ? JumpStarState.nonMark:JumpStarState.Mark
            let transformAnima = CABasicAnimation(keyPath: "transform.rotation.y")
            transformAnima.delegate = self
            transformAnima.fromValue = M_PI_2
            transformAnima.toValue = M_PI
            transformAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            let positionAnima = CABasicAnimation(keyPath: "position.y")
            positionAnima.fromValue = (startView?.center.y)! - 14
            positionAnima.toValue = (startView?.center.y)
            positionAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            
            let animGroup = CAAnimationGroup()
            animGroup.duration = jumpDuration
            animGroup.fillMode = kCAFillModeForwards
            animGroup.delegate = self
            animGroup.removedOnCompletion = false
            animGroup.animations = [transformAnima,positionAnima]
            
            startView?.layer.addAnimation(animGroup, forKey: "jumpDown")
        }
        else {
            startView?.layer.removeAllAnimations()
            animating = false
        }
    }
    
    override func animationDidStart(anim: CAAnimation) {
        if anim.isEqual(startView?.layer.animationForKey("jumpUp")) {
            
            UIView .animateWithDuration(jumpDuration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                self.shadowView?.alpha = 0.2
                self.shadowView?.bounds = CGRectMake(0, 0, (self.shadowView?.bounds.size.width)!*1.6, (self.shadowView?.bounds.size.height)!);
                }, completion: nil)
        }
        else if(anim .isEqual(self.startView?.layer.animationForKey("jumpDown"))){
            UIView .animateWithDuration(jumpDuration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                self.shadowView?.alpha = 0.4
                self.shadowView?.bounds = CGRectMake(0, 0, (self.shadowView?.bounds.size.width)!/1.6, (self.shadowView?.bounds.size.height)!);
                }, completion: nil)

        }
    }
    
    
    
}
