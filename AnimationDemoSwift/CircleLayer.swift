//
//  CircleLayer.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/10/14.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

class CircleLayer: CALayer {

    let outsideRectSize :Int32 = 90
    var progress:Float{
        set{
            progress = newValue
            if progress <= 0.5{
                movePoint = 0
                }
            else{
                movePoint = 1
            }
            lastProgress = progress
            
        }
        get{
            return progress
        }
    }
    var outsideRect:CGRect
    var lastProgress:Float
    var movePoint:Int32
    
    
    override init(){
        outsideRect = CGRectZero
        lastProgress = 0
        movePoint = 0
        super.init()
        progress = 0.5;

    }
    
    override func drawInContext(ctx: CGContext) {
        let offset = self.outsideRect.size.width / 3.6
        let moveDistance = Float(outsideRect.size.width) * 1.0/6.0 * fabs(self.progress - 0.5)*2
        let rectCenter = CGPoint(x: self.outsideRect.origin.x + self.outsideRect.size.width / 2, y: self.outsideRect.origin.y + self.outsideRect.size.height / 2)
        let pointA = CGPoint(x: rectCenter.x, y: self.outsideRect.origin.y + CGFloat(moveDistance))
        let pointB = CGPoint(x: movePoint == 0 ? rectCenter.x + self.outsideRect.size.width / 2:rectCenter.x+self.outsideRect.size.height/2 - CGFloat(moveDistance), y: rectCenter.y)
        let pointC = CGPoint(x: rectCenter.x, y:rectCenter.y + self.outsideRect.size.height/2 - CGFloat(moveDistance))
        let pointD = CGPointMake(self.movePoint == POINT_D ? self.outsideRect.origin.x - movedDistance*2 : self.outsideRect.origin.x, rectCenter.y);
    }
    
//    init(layer:CircleLayer){
//        progress = layer.progress
//        outsideRect = layer.outsideRect
//        lastProgress = layer.lastProgress
//        super.init()
//    }

    func drawPoint(points:[NSValue],context:CGContextRef){
        for pointValue in points{
            let point = pointValue.CGPointValue()
            CGContextFillRect(context, CGRectMake(point.x - 2, point.y - 2, 4, 4))
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
