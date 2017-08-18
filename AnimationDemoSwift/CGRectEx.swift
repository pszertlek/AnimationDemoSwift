//
//  CGRectEx.swift
//  AnimationDemoSwift
//
//  Created by Coco on 15/12/21.
//  Copyright © 2015年 Pszertlek. All rights reserved.
//

import UIKit

extension CGRect {
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self = CGRect(x: newValue, y: self.y, width: self.width, height: self.height)
        }
    }
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            self = CGRect(x:self.x,y:newValue,width:self.width,height:self.height)
        }
    }
    var width: CGFloat {
        get {
            return self.size.width
        }
        set {
            self = CGRect(x:self.x,y:self.y,width:newValue,height:self.height)
        }
    }
    var height: CGFloat {
        get {
            return self.size.height
        }
        set {
            self = CGRect(x:self.x,y:self.y,width:self.width,height:newValue)
        }
    }
    var top: CGFloat {
        get {
            return self.origin.y
        }
        set {
            y = newValue
        }
    }
    var bottom: CGFloat {
        get {
            return y + height
        }
        set {
            y = newValue - height
        }
    }
    var left: CGFloat {
        get {
            return x
        }
        set {
            x = newValue
        }
    }
    var right: CGFloat {
        get {
            return y + width
        }
        set {
            x = newValue - width
        }
    }
    var midX: CGFloat {
        get {
            return x + width / 2
        }
        set {
            x = newValue - width / 2
        }
    }
    var midY: CGFloat {
        get {
            return y + height / 2
        }
        set {
            x = newValue - height / 2
        }
    }
}
