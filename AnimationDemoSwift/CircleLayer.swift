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
            outsideRect = CGRect(x: originX, y:originY,width:outsideRectSize,height:outsideRectSize)
            setNeedsDisplay()
            
        }
    }

    
    

    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        if let layer = layer as? CircleLayer {
            progress = layer.progress
            outsideRect = layer.outsideRect
            lastProgress = layer.lastProgress
        }
    }
    
    
    override func draw(in ctx: CGContext) {
        let offset = self.outsideRect.size.width / 3.6
        let moveDistance = CGFloat(outsideRect.size.width) * 1.0/6.0 * CGFloat(fabs(self.progress - 0.5)*2)
        let rectCenter = CGPoint(x: self.outsideRect.origin.x + self.outsideRect.size.width / 2, y: self.outsideRect.origin.y + self.outsideRect.size.height / 2)
        let pointA = CGPoint(x: rectCenter.x, y: self.outsideRect.origin.y + CGFloat(moveDistance))
        let pointB = CGPoint(x: movePoint == .POINT_B ? rectCenter.x + self.outsideRect.size.width / 2:rectCenter.x+self.outsideRect.size.height/2 - CGFloat(moveDistance), y: rectCenter.y)
        let pointC = CGPoint(x: rectCenter.x, y:rectCenter.y + self.outsideRect.size.height/2 - CGFloat(moveDistance))
        let pointD = CGPoint(x: self.movePoint == .POINT_B ? self.outsideRect.origin.x - CGFloat(moveDistance)*2 : self.outsideRect.origin.x,y: rectCenter.y);
        
        let c1 = CGPoint(x:pointA.x + offset,y: pointA.y);
        let c2 = CGPoint(x:pointB.x,y: self.movePoint == .POINT_B ? pointB.y - offset : pointB.y - offset + moveDistance);
        
        let c3 = CGPoint(x:pointB.x,y: self.movePoint == .POINT_B ? pointB.y + offset : pointB.y + offset - moveDistance);
        let c4 = CGPoint(x:pointC.x + offset,y: pointC.y);
        
        let c5 = CGPoint(x:pointC.x - offset,y: pointC.y);
        let c6 = CGPoint(x:pointD.x,y: self.movePoint == .POINT_B ? pointD.y + offset - moveDistance : pointD.y + offset);
        
        let c7 = CGPoint(x:pointD.x,y: self.movePoint == .POINT_B ? pointD.y - offset + moveDistance : pointD.y - offset);
        let c8 = CGPoint(x:pointA.x - offset,y: pointA.y);
        let rectPath = UIBezierPath(rect: outsideRect)
        
        ctx.addPath(rectPath.cgPath)
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.setLineWidth(1.0)
//        let dash = [5.0,5.0]
//        CGContextSetLineDash(ctx, 0.0, dash, 2)
        ctx.strokePath()
        
        let ovalPath = UIBezierPath()
        ovalPath.move(to: pointA)
        ovalPath.addCurve(to: pointB, controlPoint1: c1, controlPoint2: c2)
        ovalPath.addCurve(to: pointB, controlPoint1: c1, controlPoint2: c2)
        ovalPath.addCurve(to: pointC, controlPoint1: c3, controlPoint2: c4)
        ovalPath.addCurve(to: pointD, controlPoint1: c5, controlPoint2: c6)
        ovalPath.addCurve(to: pointA, controlPoint1: c7, controlPoint2: c8)
        
        ovalPath.close()
        
        ctx.addPath(ovalPath.cgPath)
        
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.setLineDash(phase: 0, lengths: [])
        ctx.drawPath(using: .fillStroke)
        
        let helperPath = UIBezierPath()
        helperPath.move(to: pointA)
        helperPath.addLine(to: c1)
        helperPath.addLine(to: c2)
        helperPath.addLine(to: pointB)
        helperPath.addLine(to: c3)
        helperPath.addLine(to: c4)
        helperPath.addLine(to: pointC)
        helperPath.addLine(to: c5)
        helperPath.addLine(to: c6)
        helperPath.addLine(to: pointD)
        helperPath.addLine(to: c7)
        helperPath.addLine(to: c8)
        helperPath.close()
        

        
        ctx.addPath(helperPath.cgPath);
        
//        CGFloat dash2[] = {2.0, 2.0};
//        CGContextSetLineDash(ctx, 0.0, dash2, 2);
     //给辅助线条填充颜色
        ctx.strokePath()
    }
    
//    init(layer:CircleLayer){
//        progress = layer.progress
//        outsideRect = layer.outsideRect
//        lastProgress = layer.lastProgress
//        super.init()
//    }

    func drawPoint(points:[NSValue],context:CGContext){
        for pointValue in points{
            let point = pointValue.cgPointValue
            context.fill(CGRect(x:point.x - 2,y: point.y - 2,width: 4,height: 4))
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
