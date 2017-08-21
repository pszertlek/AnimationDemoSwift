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
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let ctx = transitionContext
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containView = transitionContext.containerView as UIView
        
        
        
        
    }
    
    func animationEnded(transitionCompleted: Bool) {
        
    }
}
