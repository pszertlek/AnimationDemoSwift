//
//  DynamicsViewController.swift
//  AnimationDemoSwift
//
//  Created by Coco on 16/2/22.
//  Copyright © 2016年 Pszertlek. All rights reserved.
//

import UIKit

class DynamicsViewController: UIViewController {

    @IBOutlet weak var restoreButton: UIButton!
    private var lockScreenView: UIImageView!
    private var animator: UIDynamicAnimator!
    private var gravityBehaviour: UIGravityBehavior!
    private var pushBehavior: UIPushBehavior!
    private var attachmentBehaviour: UIAttachmentBehavior!
    private var itemBehaviour: UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lockScreenView = UIImageView(frame: view.bounds)
        lockScreenView.image = UIImage(named: "lockSceen")
        lockScreenView.contentMode = .ScaleToFill
        lockScreenView.userInteractionEnabled = true
        view.addSubview(lockScreenView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapOnIt:")
        lockScreenView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: "panOnIt:")
        lockScreenView.addGestureRecognizer(panGesture)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        animator = UIDynamicAnimator(referenceView: view)
        let collisionBehaviour = UICollisionBehavior(items: [lockScreenView])
        collisionBehaviour.setTranslatesReferenceBoundsIntoBoundaryWithInsets(UIEdgeInsets(top: -lockScreenView.frame.height, left: 0, bottom: 0, right: 0))
        gravityBehaviour = UIGravityBehavior(items: [lockScreenView])
        gravityBehaviour.gravityDirection = CGVector(dx: 0.0, dy: 1.0)
        gravityBehaviour.magnitude = 2.6
        animator.addBehavior(gravityBehaviour)
        
        pushBehavior = UIPushBehavior(items: [lockScreenView], mode: .Instantaneous)
        pushBehavior.magnitude = 2.0
        pushBehavior.angle = CGFloat(M_PI)
        animator.addBehavior(pushBehavior)
        
        itemBehaviour = UIDynamicItemBehavior(items: [lockScreenView])
        itemBehaviour.elasticity = 0.35
        animator.addBehavior(itemBehaviour)
    }
    
    @objc private func topOnIt(tapGes: UITapGestureRecognizer) {
        pushBehavior.pushDirection = CGVector(dx: 0.0, dy: -80.0)
        pushBehavior.active = true
    }
    
    @objc private func panOnIt(panGes: UIPanGestureRecognizer) {
        let location = CGPoint(x: CGRectGetMinX(lockScreenView.frame), y: panGes.locationInView(view).y)
        if panGes.state == .Began {
            animator.removeBehavior(gravityBehaviour)
            attachmentBehaviour = UIAttachmentBehavior(item: lockScreenView, attachedToAnchor: location)
            animator.addBehavior(attachmentBehaviour)
        }
        else if panGes.state == .Changed {
            attachmentBehaviour.anchorPoint = location
        }
        else if panGes.state == .Ended {
            let velocity = panGes.velocityInView(lockScreenView)
            animator.removeBehavior(attachmentBehaviour)
            attachmentBehaviour = nil
            if velocity.y < -1300 {
                animator.removeBehavior(gravityBehaviour)
                animator.removeBehavior(itemBehaviour)
                gravityBehaviour = nil
                itemBehaviour = nil
                
                gravityBehaviour = UIGravityBehavior(items: [lockScreenView])
                gravityBehaviour.gravityDirection = CGVector(dx: 0.0, dy: -1.0)
                gravityBehaviour.magnitude = 2.6
                animator.addBehavior(gravityBehaviour)
                
                itemBehaviour = UIDynamicItemBehavior(items: [lockScreenView])
                itemBehaviour.elasticity = 0.0
                animator.addBehavior(itemBehaviour)
                
                pushBehavior.pushDirection = CGVector(dx: 0.0, dy: -200.0)
                pushBehavior.active = true
            }
            else {
                restore(restoreButton)
            }
        }
    }
    
    @IBAction func restore(sender:AnyObject) {
        animator.removeBehavior(gravityBehaviour)
        animator.removeBehavior(itemBehaviour)
        gravityBehaviour = nil
        itemBehaviour = nil
        
        //gravity
        gravityBehaviour = UIGravityBehavior(items: [lockScreenView])
        gravityBehaviour.gravityDirection = CGVector(dx: 0.0, dy: 1.0)
        gravityBehaviour.magnitude = 2.6
        
        //item
        itemBehaviour = UIDynamicItemBehavior(items: [lockScreenView])
        itemBehaviour.elasticity = 0.35
        animator.addBehavior(itemBehaviour)
        animator.addBehavior(gravityBehaviour)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
