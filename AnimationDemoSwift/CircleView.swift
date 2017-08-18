//
//  CircleView.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/10/14.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

class CircleView: UIView {

    var circleLayer :CircleLayer
    
    override init(frame: CGRect) {
        circleLayer = CircleLayer()
        circleLayer.contentsScale = UIScreen.main.scale;
        super.init(frame: frame)
        layer.addSublayer(circleLayer)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
