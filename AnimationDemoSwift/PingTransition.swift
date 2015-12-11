//
//  PingTransition.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/12/3.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

class PingTransition : NSObject ,UIViewControllerAnimatedTransitioning {
    
    var transitionContext : UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        let interval :NSTimeInterval = 0.7
        return interval
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! TransitionFirstViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! TransitionSecondViewController
        let contView = transitionContext.containerView()
        let button = fromVC.button
        let maskStartBP = UIBezierPath(ovalInRect: button.frame)
        
        contView?.addSubview(fromVC.view)
        contView?.addSubview(toVC.view)
        
        var finalPoint : CGPoint!
//        let center = button.center
//        let x = center.x > fromVC.view.frame.size.width - center.x ? center.x : fromVC.view.frame.size.width - center.x
//        let y = center.y > fromVC.view.frame.size.height/2 ? center.y : fromVC.view.frame.size.width - center.y
        if(button.frame.origin.x > (toVC.view.bounds.size.width / 2)){
            if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
                //第一象限
                finalPoint = CGPointMake(button.center.x - 0, button.center.y - CGRectGetMaxY(toVC.view.bounds)+30);
            }else{
                //第四象限
                finalPoint = CGPointMake(button.center.x - 0, button.center.y - 0);
            }
        }else{
            if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
                //第二象限
                finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - CGRectGetMaxY(toVC.view.bounds)+30);
            }else{
                //第三象限
                finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - 0);
            }
        }
        let radius = sqrt(finalPoint.x * finalPoint.x + finalPoint.y * finalPoint.y)

        let maskFinalBP = UIBezierPath(ovalInRect: CGRectInset(button.frame, 0 - radius,0 - radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskFinalBP.CGPath
        toVC.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = maskStartBP.CGPath
        maskLayerAnimation.toValue = maskFinalBP.CGPath
        maskLayerAnimation.duration = self.transitionDuration(transitionContext)
        maskLayerAnimation.delegate = self
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
        
        
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        transitionContext?.completeTransition(true)
        transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)!.view.layer.mask = nil
        transitionContext?.viewControllerForKey(UITransitionContextToViewControllerKey)!.view.layer.mask = nil

    }
    
    
}