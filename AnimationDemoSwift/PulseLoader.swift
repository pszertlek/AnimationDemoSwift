//
//  PulseLoader.swift
//  AnimationDemoSwift
//
//  Created by Coco on 16/3/23.
//  Copyright © 2016年 Pszertlek. All rights reserved.
//

import UIKit

class PulseLoader: UIView {

    var pulseLayer: CAShapeLayer!
    var color: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        color = UIColor.red
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        pulseLayer = CAShapeLayer()
        pulseLayer.frame = self.bounds
        pulseLayer.path = UIBezierPath(ovalIn:bounds).cgPath
        pulseLayer.fillColor = color.cgColor
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.instanceCount = 8
        replicatorLayer.instanceDelay = 0.5
        replicatorLayer.bounds = pulseLayer.bounds
        
        replicatorLayer.addSublayer(pulseLayer)
        pulseLayer.opacity = 0

        self.layer.addSublayer(replicatorLayer)
        
    }
    
    func startAnimate() {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [alphaAnimation(),scaleAnimation()]
        groupAnimation.duration = 4.0
        groupAnimation.autoreverses = false
        groupAnimation.repeatCount = HUGE
        pulseLayer.add(groupAnimation, forKey: "groupAnimation")
    }
    
    func alphaAnimation() -> CABasicAnimation {
        let alphaAnimation = CABasicAnimation(keyPath:"opacity")
        alphaAnimation.fromValue = NSNumber(value: 1)
        alphaAnimation.toValue = NSNumber(value: 0)
        return alphaAnimation
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath:"transform")
        let t1 = CATransform3DScale(CATransform3DIdentity, 0, 0, 0)
        let t2 = CATransform3DScale(CATransform3DIdentity, 1, 1, 0)
        scaleAnimation.fromValue = NSValue(caTransform3D: t1)
        scaleAnimation.toValue = NSValue(caTransform3D: t2)
        return scaleAnimation
    }
}
