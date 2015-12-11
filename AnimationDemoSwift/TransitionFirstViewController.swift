//
//  TransitionFirstViewController.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/12/3.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

class TransitionFirstViewController : UIViewController,UINavigationControllerDelegate {
    var button : UIButton!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "IMG_3477"))
        imageView.frame = self.view.bounds
        self.view.addSubview(imageView)

        button = UIButton(type:.System)
        button.frame = CGRectMake(UIScreen.mainScreen().bounds.width - 100, 0,  100, 100)
        button.backgroundColor = UIColor.redColor()
        view.addSubview(button)
        
        button .addTarget(self, action: Selector("btnClick"), forControlEvents: .TouchUpInside)
    }
    
    func btnClick() {
        let vc = TransitionSecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .Push :
            return PingTransition()
        default:
            return nil
        }
        
    }
}