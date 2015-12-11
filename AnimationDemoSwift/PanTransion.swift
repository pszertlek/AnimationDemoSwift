//
//  PanTransion.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/12/11.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

class PanTransion: NSObject,UIViewControllerAnimatedTransitioning {
    var ctx : UIViewControllerContextTransitioning!
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let ctx = transitionContext
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containView = transitionContext.containerView()! as UIView
        
        
        
        
    }
    
    func animationEnded(transitionCompleted: Bool) {
        
    }
}
