//
//  DynamicCollectionViewLayout.swift
//  AnimationDemoSwift
//
//  Created by Coco on 16/3/22.
//  Copyright © 2016年 Pszertlek. All rights reserved.
//

import UIKit

class DynamicCollectionViewLayout: UICollectionViewFlowLayout {
/*
    private lazy var visibleIndexPathSet = NSMutableSet()
    private var dynamicAnimator :UIDynamicAnimator!
    private var latestDelta: CGFloat = 0
    override init() {
        super.init()
        dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        self.itemSize = CGSize(width:44,height: 44);
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    }

    required init?(coder aDecoder: NSCoder) {
        super.init()
        dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
        self.minimumInteritemSpacing = 10;
        self.minimumLineSpacing = 10;
        self.itemSize = CGSize(width:44,height: 44);
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    }
    
    override func prepare() {
        super.prepare()
        print("prepareLayout")
        
        let visibleRect = CGRect(origin: self.collectionView!.bounds.origin, size: self.collectionView!.frame.size).insetBy(dx: -100, dy: -100)
        var itemVisibleIndexPath = super.layoutAttributesForElements(in: visibleRect)
        let itemVisibleIndexPathSet = NSMutableSet(array: itemVisibleIndexPath!).value(forKeyPath: "indexPath")!
        let noLongerVisibleBeviours = self.dynamicAnimator.behaviors.filter { (behaviour:UIDynamicBehavior) -> Bool in
            let attachmentBehaviour = behaviour as! UIAttachmentBehavior
            let attribute = attachmentBehaviour.items.first as! UICollectionViewLayoutAttributes
            let indexPath = (itemVisibleIndexPathSet as AnyObject).member(attribute.indexPath) != nil
            return !indexPath
            
        }
        
        for item in noLongerVisibleBeviours {
            self.dynamicAnimator.removeBehavior(item)
            let behavior = item as! UIAttachmentBehavior
            let attribute = behavior.items.first as! UICollectionViewLayoutAttributes
            self.visibleIndexPathSet.remove(attribute.indexPath)
        }
        
        let newlyVisibleBeviours = itemVisibleIndexPath!.filter { (attribute:UICollectionViewLayoutAttributes) -> Bool in
            let currentVisible = self.visibleIndexPathSet.member(attribute.indexPath) != nil
            return !currentVisible
        }
        let touchLocation = self.collectionView!.panGestureRecognizer.location(in: self.collectionView);

        for item in newlyVisibleBeviours {
            var center = item.center
            let springBehaviour = UIAttachmentBehavior(item: item, attachedToAnchor: center)
            springBehaviour.length = 0.0
            springBehaviour.damping = 0.8
            springBehaviour.frequency = 1.0
            if (!CGPointEqualToPoint(CGPoint(), touchLocation)) {
                let yDistanceFromTouch = fabsf(Float((touchLocation.y - springBehaviour.anchorPoint.y)))
                let xDistanceFromTouch = fabsf(Float(touchLocation.x - springBehaviour.anchorPoint.x));
                let scrollResistance = CGFloat((yDistanceFromTouch + xDistanceFromTouch) / 1500.0);
                
                if (self.latestDelta < 0) {
                    center.y += max(self.latestDelta, self.latestDelta*scrollResistance);
                }
                else {
                    center.y += min(self.latestDelta, self.latestDelta*scrollResistance);
                }
                item.center = center;
                self.dynamicAnimator.addBehavior(springBehaviour)
                self.visibleIndexPathSet.addObject(item.indexPath)
            }

        }
        
    }
    
    // UICollectionView calls these four methods to determine the layout information.
    // Implement -layoutAttributesForElementsInRect: to return layout attributes for for supplementary or decoration views, or to perform layout in an as-needed-on-screen fashion.
    // Additionally, all layout subclasses should implement -layoutAttributesForItemAtIndexPath: to return layout attributes instances on demand for specific index paths.
    // If the layout supports any supplementary or decoration view types, it should also implement the respective atIndexPath: methods for those types.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("layoutAttributesForElementsInRect")
        return dynamicAnimator.items(in: rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        print("layoutAttributesForItemAtIndexPath")
        return dynamicAnimator.layoutAttributesForCellAtIndexPath(indexPath)
    }
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes {
        print("layoutAttributesForSupplementaryViewOfKind")
        return super.layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath: indexPath)!
    }
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        print("layoutAttributesForDecorationViewOfKind")
        return self.layoutAttributesForDecorationViewOfKind(elementKind, atIndexPath: indexPath)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        print("shouldInvalidateLayoutForBoundsChange")
        self.latestDelta = newBounds.origin.y - self.collectionView!.bounds.y
        let touchLocation = self.collectionView!.panGestureRecognizer.locationInView(self.collectionView!)
        for behavior in self.dynamicAnimator.behaviors{
            let springBehaviour = behavior as! UIAttachmentBehavior
            let item = springBehaviour.items.first as! UICollectionViewLayoutAttributes
            let yDistanceFromTouch = fabsf(Float((touchLocation.y - springBehaviour.anchorPoint.y)))
            let xDistanceFromTouch = fabsf(Float(touchLocation.x - springBehaviour.anchorPoint.x));
            let scrollResistance = CGFloat((yDistanceFromTouch + xDistanceFromTouch) / 1500.0);
            var center = springBehaviour.items.first!.center
            if (self.latestDelta < 0) {
                center.y += max(self.latestDelta, self.latestDelta*scrollResistance);
            }
            else {
                center.y += min(self.latestDelta, self.latestDelta*scrollResistance);
            }
            item.center = center;
            self.dynamicAnimator.updateItemUsingCurrentState(item)
        }
        
        return super.shouldInvalidateLayoutForBoundsChange(newBounds)
    }
    
    @available(iOS 7.0, *)
    override func invalidationContextForBoundsChange(newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        print("invalidationContextForBoundsChange")
        return super.invalidationContextForBoundsChange(newBounds)

        
    }
    
    @available(iOS 8.0, *)
    override func shouldInvalidateLayoutForPreferredLayoutAttributes(preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        print("shouldInvalidateLayoutForPreferredLayoutAttributes")
        return super.shouldInvalidateLayoutForPreferredLayoutAttributes(preferredAttributes, withOriginalAttributes: originalAttributes)
    }
    @available(iOS 8.0, *)
    override func invalidationContextForPreferredLayoutAttributes(preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutInvalidationContext {
        print("invalidationContextForPreferredLayoutAttributes")
        return super.invalidationContextForPreferredLayoutAttributes(preferredAttributes, withOriginalAttributes: originalAttributes)
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint // return a point at which to rest after scrolling - for layouts that want snap-to-point scrolling behavior
    {
        print("targetContentOffsetForProposedContentOffset:proposedContentOffset:velocity")
        return super.targetContentOffsetForProposedContentOffset(proposedContentOffset, withScrollingVelocity: velocity)
    }
    @available(iOS 7.0, *)
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
        print("targetContentOffsetForProposedContentOffset:proposedContentOffset")
        return super.targetContentOffsetForProposedContentOffset(proposedContentOffset)
    }
    
    override func collectionViewContentSize() -> CGSize {
        print("collectionViewContentSize")
        return super.collectionViewContentSize()
    }*/
}
