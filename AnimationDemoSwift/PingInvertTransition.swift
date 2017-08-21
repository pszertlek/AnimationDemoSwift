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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        ctx = transitionContext
        let container = ctx.containerView
        let fromVC = ctx.viewController(forKey: UITransitionContextViewControllerKey.from)! as UIViewController
        let toVC = ctx.viewController(forKey: UITransitionContextViewControllerKey.to)! as UIViewController
        container.addSubview(fromVC.view)
        container.addSubview(toVC.view)

        let startPath = UIBezierPath(ovalIn: CGRect(x:20,y: 20,width: 50,height: 50))
        let radius = fromVC.view.frame.height - 70
        let endPath = UIBezierPath(ovalIn: CGRect(x:20 - radius,y: 20 - radius,width: 2 * radius,height:2 * radius))
        
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath(ovalIn: CGRect(x:20,y: 20,width: 50,height: 50).insetBy(dx: -radius, dy: -radius))
        shapeLayer.path = path.cgPath
        toVC.view.layer.mask = shapeLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = endPath.cgPath
        animation.toValue = startPath.cgPath
        animation.duration = self.transitionDuration(using: ctx)
        animation.delegate = self as? CAAnimationDelegate
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        shapeLayer.add(animation, forKey: "path")

    }
    
 func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        ctx.completeTransition(true)
    let fromVC = ctx.viewController(forKey: UITransitionContextViewControllerKey.from)! as UIViewController
//    let fromVC = ctx.viewControllerForKey(UITransitionContextViewControllerKey.from)! as UIViewControllerUITransitionContextViewControllerKey.from
    let toVC = ctx.viewController(forKey: UITransitionContextViewControllerKey.to)! as UIViewController
//    let toVC = ctx.viewControllerForKey(UITransitionContextViewControllerKey.to)! as UIViewControllerUITransitionContextViewControllerKey.to
        fromVC.view.layer.mask = nil
        toVC.view.layer.mask = nil
    }
}
