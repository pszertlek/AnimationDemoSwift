//
//  AppDelegate.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/10/14.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor(red: 128.0/255.0, green: 0.0, blue: 0.0, alpha: 1.0)
        guard let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else {
            return true
        }
        window?.rootViewController = navigationController
        
        let maskLayer = CALayer()
        maskLayer.contents = UIImage(named: "logo")?.CGImage
        maskLayer.bounds = CGRectMake(0, 0, 60, 60)
        maskLayer.position = navigationController.view.center
        navigationController.view.layer.mask = maskLayer
        
        
        let maskBackgroundView = UIView(frame: navigationController.view.bounds)
        maskBackgroundView.backgroundColor = UIColor.whiteColor()
        navigationController.view.addSubview(maskBackgroundView)
        navigationController.view.bringSubviewToFront(maskBackgroundView)
        
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        animation.duration = 1.0
        animation.beginTime = CACurrentMediaTime() + 1.0
        
        let initialbounds = maskLayer.bounds
        let secondBounds = CGRectMake(0, 0, 50, 50)
        let finalbounds = CGRectMake(0, 0, 2000, 2000)
        animation.values = [NSValue(CGRect: initialbounds),NSValue(CGRect: secondBounds),NSValue(CGRect:finalbounds)]
        animation.keyTimes = [0.0,0.5,1.0]
        animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        navigationController.view.layer.mask?.addAnimation(animation, forKey: "logoMaskAnimation")
        
        UIView.animateWithDuration(0.1, delay: 1.35, options: .CurveEaseIn, animations: { () -> Void in
            maskBackgroundView.alpha = 0.0
            }) { (finished) -> Void in
                maskBackgroundView.removeFromSuperview()
        }
        
        UIView.animateWithDuration(0.25, delay: 1.3, options: .TransitionNone, animations: { () -> Void in
            navigationController.view.transform = CGAffineTransformMakeScale(1.05, 1.05)
            }) { (finished) -> Void in
                UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                    navigationController.view.transform = CGAffineTransformIdentity
                    }, completion: { (finished) -> Void in
                        navigationController.view.layer.mask = nil
                })
        }
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

