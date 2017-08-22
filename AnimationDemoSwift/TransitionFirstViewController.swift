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
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "IMG_3477"))
        imageView.frame = self.view.bounds
        self.view.addSubview(imageView)

        button = UIButton(type:.system)
        button.frame = CGRect(x:UIScreen.main.bounds.width - 100,y: 0,width:  100,height: 100)
        button.backgroundColor = UIColor.red
        view.addSubview(button)
        
        button .addTarget(self, action: Selector(("btnClick")), for: .touchUpInside)
    }
    
    func btnClick() {
        let vc = TransitionSecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push :
            return PingTransition()
        default:
            return nil
        }
        
    }
}
