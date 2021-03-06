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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        percentTransition = UIPercentDrivenInteractiveTransition()
//        let edgeGes = UIScreenEdgePanGestureRecognizer(target:self,action:Selector"")
//        let edgeGes = UIScreenEdgePanGestureRecognizer(target: self, action: Selector("edgePan:"))
//        edgeGes.edges = .left
//        self.view.addGestureRecognizer(edgeGes)

        
        let imageView = UIImageView(image: UIImage(named: "IMG_3476"))
        imageView.frame = self.view.bounds
        self.view.addSubview(imageView)
        button = UIButton(type:.system)
        button.frame = CGRect(x:0, y:0,  width:100, height:100)
        view.addSubview(button)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(btnClick), for:.touchUpInside)
    }
    
//    func edgePan(recognizer: UIPanGestureRecognizer) {
//        let per = recognizer.translationInView(self.view).x /
//    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PingInvertTransition()
    }
//    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//    }
    
    @objc func btnClick() {
        self.navigationController?.popViewController(animated: true)
//        let vc = TransitionSecondViewController()
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }


}
