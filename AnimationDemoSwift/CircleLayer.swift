//
//  CircleLayer.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/10/14.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

enum MovingPoint {
    case POINT_D
    case POINT_B
}

let outsideRectSize :CGFloat = 90
class CircleLayer: CALayer {

    private var outsideRect:CGRect!
    private var lastProgress:CGFloat = 0.5
    private var movePoint:MovingPoint!
    var progress: CGFloat = 0.0{
        didSet{
            if progress <= 0.5 {
                movePoint = .POINT_B
            }
            else {
                movePoint = .POINT_D
            }
            self.lastProgress = progress
            let buff = (progress - 0.5) * (frame.size.width - outsideRectSize)
            let originX = position.x - outsideRectSize / 2 + buff
            let originY = position.y - outsideRectSize / 2
            outsideRect = CGRectMake(originX, originY, outsideRectSize, outsideRectSize)
            setNeedsDisplay()
            
        }
    }

    
    

    override init() {
        super.init()
    }
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
        if let layer = layer as? CircleLayer {
            progress = layer.progress
            outsideRect = layer.outsideRect
            lastProgress = layer.lastProgress
        }
    }
    
    override func drawInContext(ctx: CGContext) {
        let offset = self.outsideRect.size.width / 3.6
        let moveDistance = CGFloat(outsideRect.size.width) * 1.0/6.0 * CGFloat(fabs(self.progress - 0.5)*2)
        let rectCenter = CGPoint(x: self.outsideRect.origin.x + self.outsideRect.size.width / 2, y: self.outsideRect.origin.y + self.outsideRect.size.height / 2)
        let pointA = CGPoint(x: rectCenter.x, y: self.outsideRect.origin.y + CGFloat(moveDistance))
        let pointB = CGPoint(x: movePoint == .POINT_B ? rectCenter.x + self.outsideRect.size.width / 2:rectCenter.x+self.outsideRect.size.height/2 - CGFloat(moveDistance), y: rectCenter.y)
        let pointC = CGPoint(x: rectCenter.x, y:rectCenter.y + self.outsideRect.size.height/2 - CGFloat(moveDistance))
        let pointD = CGPointMake(self.movePoint == .POINT_B ? self.outsideRect.origin.x - CGFloat(moveDistance)*2 : self.outsideRect.origin.x, rectCenter.y);
        
        let c1 = CGPointMake(pointA.x + offset, pointA.y);
        let c2 = CGPointMake(pointB.x, self.movePoint == .POINT_B ? pointB.y - offset : pointB.y - offset + moveDistance);
        
        let c3 = CGPointMake(pointB.x, self.movePoint == .POINT_B ? pointB.y + offset : pointB.y + offset - moveDistance);
        let c4 = CGPointMake(pointC.x + offset, pointC.y);
        
        let c5 = CGPointMake(pointC.x - offset, pointC.y);
        let c6 = CGPointMake(pointD.x, self.movePoint == .POINT_B ? pointD.y + offset - moveDistance : pointD.y + offset);
        
        let c7 = CGPointMake(pointD.x, self.movePoint == .POINT_B ? pointD.y - offset + moveDistance : pointD.y - offset);
        let c8 = CGPointMake(pointA.x - offset, pointA.y);
        let rectPath = UIBezierPath(rect: outsideRect)
        
        CGContextAddPath(ctx, rectPath.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetLineWidth(ctx, 1.0)
//        let dash = [5.0,5.0]
//        CGContextSetLineDash(ctx, 0.0, dash, 2)
        CGContextStrokePath(ctx)
        
        let ovalPath = UIBezierPath()
        ovalPath .moveToPoint(pointA)
        ovalPath.addCurveToPoint(pointB, controlPoint1: c1, controlPoint2: c2)
        ovalPath.addCurveToPoint(pointC, controlPoint1: c3, controlPoint2: c4)
        ovalPath.addCurveToPoint(pointD, controlPoint1: c5, controlPoint2: c6)
        ovalPath.addCurveToPoint(pointA, controlPoint1: c7, controlPoint2: c8)
        
        ovalPath .closePath()
        
        CGContextAddPath(ctx, ovalPath.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetFillColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextSetLineDash(ctx, 0, nil, 0)
        CGContextDrawPath(ctx,.FillStroke)
        
        let helperPath = UIBezierPath()
        helperPath.moveToPoint(pointA)
        helperPath.addLineToPoint(c1)
        helperPath.addLineToPoint(c2)
        helperPath.addLineToPoint(pointB)
        helperPath.addLineToPoint(c3)
        helperPath.addLineToPoint(c4)
        helperPath.addLineToPoint(pointC)
        helperPath.addLineToPoint(c5)
        helperPath.addLineToPoint(c6)
        helperPath.addLineToPoint(pointD)
        helperPath.addLineToPoint(c7)
        helperPath.addLineToPoint(c8)
        helperPath .closePath()
        
        
        CGContextAddPath(ctx, helperPath.CGPath);
        
//        CGFloat dash2[] = {2.0, 2.0};
//        CGContextSetLineDash(ctx, 0.0, dash2, 2);
        CGContextStrokePath(ctx); //给辅助线条填充颜色

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
