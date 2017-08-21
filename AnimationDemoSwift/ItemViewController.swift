//
//  ItemViewController.swift
//  AnimationDemoSwift
//
//  Created by Coco on 16/3/23.
//  Copyright © 2016年 Pszertlek. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let pulseLoader = PulseLoader(frame: CGRect(x:25,y:25,width:50,height:50))
        self.view.addSubview(pulseLoader)
        pulseLoader.startAnimate()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
