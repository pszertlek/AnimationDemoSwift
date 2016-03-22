//
//  FireworksView.swift
//  AnimationDemoSwift
//
//  Created by Coco on 16/3/16.
//  Copyright © 2016年 Pszertlek. All rights reserved.
//

import UIKit

class FireworksView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var particleImage: UIImage? {
        didSet {
            for cell in self.emitterCells {
                cell.contents = particleImage!.CGImage
            }
        }
    }
    var particleScale: CGFloat = 1.0{
        didSet {
            for cell in self.emitterCells {
                cell.scale = particleScale
            }
        }
    }
    var particleScaleRange: CGFloat = 0 {
        didSet {
            for cell in self.emitterCells {
                cell.scaleRange = particleScaleRange
            }
        }
    }
    var emitterCells: [CAEmitterCell]!
    var chargeLayer: CAEmitterLayer!
    var explosionLayer: CAEmitterLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let explosionCell = CAEmitterCell()
        explosionCell.name = "explosion"
        explosionCell.alphaRange = 0.2
        explosionCell.alphaSpeed = -1.0
        explosionCell.lifetime = 0.7
        explosionCell.lifetimeRange = 0.3
        explosionCell.birthRate = 0
        explosionCell.velocity = 40.0
        explosionCell.velocityRange = 10.00
        explosionCell.velocity = 40.0
        
        explosionLayer = CAEmitterLayer()
        explosionLayer.emitterShape = kCAEmitterLayerCircle
        explosionLayer.name = "emitterLayer"
        explosionLayer.emitterSize = CGSizeMake(25.0, 0)
        explosionLayer.emitterCells = [explosionCell]
        explosionLayer.renderMode = kCAEmitterLayerOldestFirst
        explosionLayer.masksToBounds = false
        explosionLayer.emitterMode = kCAEmitterLayerOutline
        self.layer.addSublayer(explosionLayer)
        
        let  chargeCell = CAEmitterCell()
        chargeCell.name = "charge"
        chargeCell.alphaRange = 0.2
        chargeCell.alphaSpeed = -1.0
        chargeCell.lifetime = 0.3
        chargeCell.lifetimeRange = 0.1
        chargeCell.birthRate = 0
        chargeCell.velocity = -40.0
        chargeCell.velocityRange = 0.0
        
        
        chargeLayer = CAEmitterLayer()
        chargeLayer.name = "emitterLayer"
        chargeLayer.emitterShape = kCAEmitterLayerCircle
        chargeLayer.emitterMode = kCAEmitterLayerOutline
        chargeLayer.renderMode = kCAEmitterLayerOldestFirst
        chargeLayer.masksToBounds = false
        chargeLayer.seed = 10
        chargeLayer.emitterCells = [chargeCell]
        chargeLayer.emitterSize = CGSizeMake(25.0, 0)
        self.layer.addSublayer(chargeLayer)
        
        self.emitterCells = [explosionCell,chargeCell]
        
    }
    
    func animate() {
        chargeLayer.beginTime = CACurrentMediaTime()
        chargeLayer.setValue(80, forKeyPath: "emitterCells.charge.birthRate")
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC/10)), dispatch_get_main_queue()) { () -> Void in
            self.exlode()
        }
    }
    
    func exlode() {
        explosionLayer.beginTime = CACurrentMediaTime()
        chargeLayer.setValue(0, forKeyPath: "emitterCells.charge.birthRate")
        chargeLayer.setValue(500, forKeyPath: "emitterCells.charge.birthRate")
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC/10)), dispatch_get_main_queue()) { () -> Void in
            self.stop()
        }

    }
    
    func stop() {
        chargeLayer.setValue(0, forKeyPath: "emitterCells.charge.birthRate")
        explosionLayer.setValue(0, forKeyPath: "emitterCells.charge.birthRate")

    }

}
