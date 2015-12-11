//
//  PingInvertTransition.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/12/7.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

class PingInvertTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var ctx: UIViewControllerContextTransitioning!
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.7
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        ctx = transitionContext
        let container = ctx.containerView()
        let fromVC = ctx.viewControllerForKey(UITransitionContextFromViewControllerKey)! as UIViewController
        let toVC = ctx.viewControllerForKey(UITransitionContextToViewControllerKey)! as UIViewController
        container?.addSubview(fromVC.view)
        container?.addSubview(toVC.view)

        let startPath = UIBezierPath(ovalInRect: CGRectMake(20, 20, 50, 50))
        let radius = fromVC.view.frame.height - 70
        let endPath = UIBezierPath(ovalInRect: CGRectMake(20 - radius, 20 - radius, 2 * radius,2 * radius))
        
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath(ovalInRect: CGRectInset(CGRectMake(20, 20, 50, 50),0 - radius,0 - radius))
        shapeLayer.path = path.CGPath
        toVC.view.layer.mask = shapeLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = endPath.CGPath
        animation.toValue = startPath.CGPath
        animation.duration = self.transitionDuration(ctx)
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        shapeLayer.addAnimation(animation, forKey: "path")

    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        ctx.completeTransition(true)
        let fromVC = ctx.viewControllerForKey(UITransitionContextFromViewControllerKey)! as UIViewController
        let toVC = ctx.viewControllerForKey(UITransitionContextToViewControllerKey)! as UIViewController
        fromVC.view.layer.mask = nil
        toVC.view.layer.mask = nil
    }
}