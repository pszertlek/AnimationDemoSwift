//
//  AnimatedCircleViewController.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/10/14.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

class AnimatedCircleViewController: UIViewController {

    @IBOutlet weak var mySlider: UISlider!
    var cv:CircleView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.cv = nil
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        self.cv = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.enabled = true
        cv = CircleView(frame: CGRectMake(self.view.frame.size.width - CGFloat(160),self.view.frame.size.height / 2 - CGFloat(160),320,320))
        self.view .addSubview(cv!)
        cv!.circleLayer.progress = CGFloat(mySlider.value)
        // Do any additional setup after loading the view.
    }

    @IBAction func sliderChange(sender: UISlider) {
        cv!.circleLayer.progress = CGFloat(mySlider.value)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.enabled = true
        
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
