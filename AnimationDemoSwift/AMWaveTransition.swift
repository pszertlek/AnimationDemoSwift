//
//  AMWaveTransition.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/12/11.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

protocol AMWaveTransitioning: NSObjectProtocol {
    func visibleCells() -> [UIView]
}

enum AMWaveTransitionType : Int {
   case Subtle
   case Nervous
   case Bounce
}

enum AMWaveInteractiveTransitionType: Int {
    case EdgePan
    case FullScreenPan
}


class AMWaveTransition: NSObject {

    
    let kDuration: NSTimeInterval = 0.65
    let kMaxDelay: NSTimeInterval = 0.15
    var duration: NSTimeInterval = 0.0
    var maxDelay: NSTimeInterval = 0.0
    var operation: UINavigationControllerOperation = .None
    var transitionType: AMWaveTransitionType = .Nervous
    var viewControllersInset: CGFloat = 20.0
    var animatedAlphaWithInteractiveTransition : Bool = false
    var inteactiveTransitionType: AMWaveInteractiveTransitionType = .EdgePan
    var screenWidth: CGFloat { return UIScreen.mainScreen().bounds.width}
    
    deinit {
        self.detachInteractiveGesture()
    }
    
    override init() {
        duration = kDuration
        maxDelay = kMaxDelay
        super.init()
    }
    
    convenience init(operation: UINavigationControllerOperation) {
        self.init()
        self.operation = operation

    }
    
    convenience init(operation: UINavigationControllerOperation, type: AMWaveTransitionType){
        self.init()
        self.operation = operation
        self.transitionType = type
    }
    
    func attachInteractiveGestureToNavigationController(navigationController: UINavigationController) {
        
    }
    
    func detachInteractiveGesture() {
        
    }
    
    

    
}

/*
extension AMWaveTransition:UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration + maxDelay
    }
    /*
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var fromVC: UIViewController
        var toVC: UIViewController
        if let vc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UINavigationController {
            fromVC = vc.visibleViewController!
        }
        else {
//            fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        }
        
        if let vc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UINavigationController {
            toVC = vc.visibleViewController!
        }
        else {
            toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        }
        transitionContext.containerView()?.addSubview(toVC.view)
        
        var delta: CGFloat = 0.0
        switch self.operation {
        case .Push:
            delta = screenWidth + self.viewControllersInset
        default:
            delta = -screenWidth - self.viewControllersInset
            
        }
        
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.view.transform = CGAffineTransformMakeTranslation(delta, 0)
        transitionContext.containerView()?.backgroundColor = fromVC.view.backgroundColor
        transitionContext.containerView()?.layoutIfNeeded()
        if self.operation == .Push {
            toVC.view.transform = CGAffineTransformMakeTranslation(1, 0)
            UIView.animateWithDuration(self.duration + self.maxDelay, delay: 0, options:UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                toVC.view.transform = CGAffineTransformIdentity
                }, completion: {(finished :Bool) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
        else {
            fromVC.view.transform = CGAffineTransformMakeTranslation(1, 0)
            toVC.view.transform = CGAffineTransformIdentity
            UIView.animateWithDuration(self.duration + self.maxDelay, delay: 0, options:UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                fromVC.view.transform = CGAffineTransformMakeTranslation(1, 0)
                }, completion: {(finished :Bool) -> Void in

                    fromVC.view.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
        }
        let fromViews = self.visibleCellsForViewController(fromVC)
        let toViews = self.visibleCellsForViewController(toVC)
        
    }*/
    
    func visibleCellsForViewController(viewController: UIViewController) -> [UIView]? {

        var visibleCells: [UIView]?
        viewController.performSelector("")
        if viewController.respondsToSelector(Selector("visibleCells")) {
            
            let vc = viewController as! AMWaveTransitioning
            visibleCells = vc.visibleCells()
        }
        else if let vc = viewController as? UITableViewController {
            visibleCells = vc.tableView.am_visibleViews()
        }
        
        if visibleCells?.count > 0 {
            return visibleCells
        }
        
        else if viewController.view != nil {
            return [viewController.view]
        }
        
        return nil
        
        
    }
}

extension UITableView {
    func am_visibleViews() -> [UIView] {
        var views = [UIView]()
        
        if self.tableHeaderView?.frame.size.height > 0 {
            views.append(self.tableHeaderView!)
        }
        
        var section = -1
        for  indexPath in self.indexPathsForVisibleRows! {
            section = indexPath.section
            var view = self.headerViewForSection(section)
            if view?.frame.size.height > 0 {
                views.append(view!)
            }
            
            for sectionIndexPath in self.indexPathsForVisibleRows! {
                if sectionIndexPath.section !=  indexPath.section {
                    continue
                }
                else {
                    let view = self.cellForRowAtIndexPath(sectionIndexPath)
                    if view?.frame.size.height > 0 {
                        views.append(view!)
                    }
                }
            }
            view = self.footerViewForSection(section)
            if view?.frame.size.height > 0 {
                views.append(view!)
            }
            
        }
        if self.tableFooterView?.frame.size.height > 0 {
            views.append(self.tableFooterView!)
        }
        
        return views
    }
}*/