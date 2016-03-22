//
//  FireworkButton.swift
//  AnimationDemoSwift
//
//  Created by Coco on 16/3/16.
//  Copyright © 2016年 Pszertlek. All rights reserved.
//

import UIKit

class FireworkButton: UIButton {

    lazy var fireworksView: FireworksView = FireworksView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        self.insertSubview(fireworksView, atIndex: 0)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fireworksView.frame = self.bounds
        self.insertSubview(fireworksView, atIndex: 0)
    }
    
    func animte() {
        self.fireworksView.animate()
    }
    
//    func popOutsideWithDuration(duration: NSTimeInterval) {
//        self.transform = CGAffineTransformIdentity
//        UIView.animateKeyframesWithDuration(duration, delay: 0, options:.UIViewKeyframeAnimationOptionLayoutSubviews, animations: { () -> Void in
//            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3333, animations: { () -> Void in
//                self.transform = CGAffineTransformMakeScale(1.5, 1.5)
//            })
//            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3333, animations: { () -> Void in
//                self.transform = CGAffineTransformMakeScale(0.8, 0.8)
//            })
//            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3333, animations: { () -> Void in
//                self.transform = CGAffineTransformMakeScale(1, 1)
//            })
//
//            }, completion: nil)
//    }
//    
//    func popInsideWithDuration(duration: NSTimeInterval) {
//        UIView.animateKeyframesWithDuration(duration, delay: 0, options:.layoutSubviews, animations: { () -> Void in
//            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3333, animations: { () -> Void in
//                self.transform = CGAffineTransformMakeScale(0.8, 0.8)
//            })
//            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3333, animations: { () -> Void in
//                self.transform = CGAffineTransformMakeScale(1, 1)
//            })
//            
//            }, completion: nil)
//
//    }
}

extension FireworkButton {
    var particleImage: UIImage {
        set {
            self.fireworksView.particleImage = newValue
        }
        get {
            return self.fireworksView.particleImage!
        }
    }
    
    var particleScale: CGFloat {
        set {
            self.fireworksView.particleScale = newValue
        }
        get {
            return self.fireworksView.particleScale
        }
    }
    
    var particleScaleRange: CGFloat {
        set {
            self.fireworksView.particleScaleRange = newValue
        }
        get {
            return self.fireworksView.particleScaleRange
        }
    }

}