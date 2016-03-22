//
//  DownloadButton.swift
//  AnimationDemoSwift
//
//  Created by Coco on 16/3/17.
//  Copyright © 2016年 Pszertlek. All rights reserved.
//

import UIKit

let kRadiusShrinkAnim = "cornerRadiusShrinkAnim"
let kRadiusExpandAnim = "radiusExpandAnimation"
let kProgressBarAnimation = "progressBarAnimation"
let kCheckAnimation = "checkAnimation"

class DownloadButton: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var progressBarHeight: CGFloat = 0.0
    var progressBarWidth: CGFloat = 0.0
    var originFrame = CGRectZero
    var animating = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initView() {
        let tapGes = UITapGestureRecognizer(target: self, action: "handleButtonDidTapped:")
        addGestureRecognizer(tapGes)
    }
    
    func handleButtonDidTapped(gesture: UITapGestureRecognizer) {
        guard !animating else {
            return
        }
        animating = true
        originFrame = frame
        if let subLayers = layer.sublayers {
            for sublayer in subLayers {
                sublayer.removeFromSuperlayer()
            }
        }
        backgroundColor = UIColor(red: 0.0, green: 122/255.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = progressBarHeight / 2
        let radiusShrinkAnimation = CABasicAnimation(keyPath: "cornerRadius")
        radiusShrinkAnimation.duration = 0.2
        radiusShrinkAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        radiusShrinkAnimation.fromValue = originFrame.height / 2
        radiusShrinkAnimation.delegate = self
        layer.addAnimation(radiusShrinkAnimation, forKey: kRadiusShrinkAnim)
    }
    
    private func progressBarAnimation() {
        let progressLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: progressBarHeight / 2, y: self.frame.height / 2))
        path.addLineToPoint(CGPointMake(bounds.size.width - progressBarHeight / 2, bounds.size.height / 2))
        
        progressLayer.path = path.CGPath
        progressLayer.strokeColor = UIColor.whiteColor().CGColor
        progressLayer.lineWidth = progressBarHeight - 6
        progressLayer.lineCap = kCALineCapRound
        layer.addSublayer(progressLayer)
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 2.0
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.delegate = self
        pathAnimation.setValue(kProgressBarAnimation, forKey: "animationName")
        progressLayer.addAnimation(pathAnimation, forKey: nil)
    }
    
    
    private func checkAnimation() {
        let checkLayer = CAShapeLayer()
        let path = UIBezierPath()
        let rectInCircle = CGRectInset(self.bounds, self.bounds.size.width*(1-1/sqrt(2.0))/2, self.bounds.size.width*(1-1/sqrt(2.0))/2)
        path.moveToPoint(CGPoint(x: rectInCircle.origin.x + rectInCircle.size.width/9, y: rectInCircle.origin.y + rectInCircle.size.height*2/3))
        path.addLineToPoint(CGPoint(x: rectInCircle.origin.x + rectInCircle.size.width/3,y: rectInCircle.origin.y + rectInCircle.size.height*9/10))
        path.addLineToPoint(CGPoint(x: rectInCircle.origin.x + rectInCircle.size.width*8/10, y: rectInCircle.origin.y + rectInCircle.size.height*2/10))
        
        checkLayer.path = path.CGPath
        checkLayer.fillColor = UIColor.clearColor().CGColor
        checkLayer.strokeColor = UIColor.whiteColor().CGColor
        checkLayer.lineWidth = 10.0
        checkLayer.lineCap = kCALineCapRound
        checkLayer.lineJoin = kCALineJoinRound
        self.layer.addSublayer(checkLayer)
        
        let checkAnimation = CABasicAnimation(keyPath: "strokeEnd")
        checkAnimation.duration = 0.3;
        checkAnimation.fromValue = 0.0
        checkAnimation.toValue = 1.0
        checkAnimation.delegate = self
        checkAnimation.setValue(kCheckAnimation, forKey:"animationName")
        checkLayer.addAnimation(checkAnimation,forKey:nil)
    }

    override func animationDidStart(anim: CAAnimation) {
        if anim.isEqual(self.layer.animationForKey(kRadiusShrinkAnim)) {
            UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                self.bounds = CGRectMake(0, 0, self.progressBarWidth, self.progressBarHeight)
                }, completion: { (Bool) -> Void in
                    self.layer.removeAllAnimations()
                    self.progressBarAnimation()
            })
        }
        else if anim.isEqual(self.layer.animationForKey(kRadiusExpandAnim)) {
            UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                self.bounds = CGRect(x: 0, y: 0, width: self.originFrame.width, height: self.originFrame.height)
                self.backgroundColor = UIColor(red: 0.1803921568627451, green: 0.8, blue: 0.44313725490196076, alpha: 1.0)
                }, completion: { (finished) -> Void in
                    self.layer.removeAllAnimations()
                    self.checkAnimation()
                    self.animating = false
            })

        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let animationName = anim.valueForKey("animationName") where
            animationName.isEqualToString(kProgressBarAnimation) {
                
        }
    
    }
}
