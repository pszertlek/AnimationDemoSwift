//
//  ViewController.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/10/14.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.interactivePopGestureRecognizer?.enabled = true

        // Do any additional setup after loading the view, typically from a nib.
        
        let snowEmitter = CAEmitterLayer()
        
        snowEmitter.emitterPosition = CGPoint(x: self.view.bounds.size.width / 2.0 , y: -30)
        snowEmitter.emitterSize = CGSize(width: self.view.bounds.size.width * 2.0, height: 0.0)
        snowEmitter.emitterShape = kCAEmitterLayerLine
        snowEmitter.emitterMode = kCAEmitterLayerPoint
        
        let snowflake = CAEmitterCell()
        snowflake.birthRate = 1.0
        snowflake.lifetime = 120.0
        snowflake.velocity = -10
        snowflake.velocityRange = 50
        snowflake.yAcceleration = 2
        snowflake.emissionRange = CGFloat(0.5 * M_PI)
        snowflake.spinRange = CGFloat(0.25 * M_PI)
        snowflake.contents = UIImage(named: "snow")?.CGImage
        snowflake.color = UIColor(red: 0.6, green: 0.658, blue: 0.743, alpha: 1.000).CGColor
        
        snowEmitter.shadowOpacity = 1.0
        snowEmitter.shadowRadius = 0.0
        snowEmitter.shadowOffset = CGSizeMake(0.0, 1.0)
        snowEmitter.shadowColor = UIColor.whiteColor().CGColor
        snowEmitter.emitterCells = [snowflake]

        view.layer.insertSublayer(snowEmitter, above: self.tableView.layer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        self.navigationController?.interactivePopGestureRecognizer?.enabled = true
        
    }

}

