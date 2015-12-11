//
//  TransitionSectionViewController.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/12/3.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

class TransitionSecondViewController: UIViewController,UINavigationControllerDelegate {
    var button: UIButton!
    var percentTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        percentTransition = UIPercentDrivenInteractiveTransition()
        let edgeGes = UIScreenEdgePanGestureRecognizer(target: self, action: Selector("edgePan:"))
        edgeGes.edges = .Left
        self.view.addGestureRecognizer(edgeGes)

        
        let imageView = UIImageView(image: UIImage(named: "IMG_3476"))
        imageView.frame = self.view.bounds
        self.view.addSubview(imageView)
        button = UIButton(type:.System)
        button.frame = CGRectMake(0, 0,  100, 100)
        view.addSubview(button)
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: Selector("btnClick"), forControlEvents: .TouchUpInside)
    }
    
//    func edgePan(recognizer: UIPanGestureRecognizer) {
//        let per = recognizer.translationInView(self.view).x /
//    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PingInvertTransition()
    }
//    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//    }
    
    func btnClick() {
        self.navigationController?.popViewControllerAnimated(true)
//        let vc = TransitionSecondViewController()
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }


}