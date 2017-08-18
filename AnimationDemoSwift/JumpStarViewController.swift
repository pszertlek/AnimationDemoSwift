//
//  JumpStarViewController.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/12/8.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

class JumpStarViewController: UIViewController {
    @IBOutlet weak var startView: JumpStarView!
    @IBAction func buttonClick(sender: AnyObject) {
        startView.animateSelf()
    }
    @IBOutlet weak var backClick: UIButton!
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        startView.layoutIfNeeded()
        startView.markImage = UIImage(named: "icon_star_incell")
        startView.nonMarkImage = UIImage(named: "blue_dot")
        startView.state = .nonMark
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

}
