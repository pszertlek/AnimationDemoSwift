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
            self = CGRectMake(newValue,self.y,self.width,self.height)
        }
    }
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            self = CGRectMake(x, newValue, width, height)
        }
    }
    var width: CGFloat {
        get {
            return self.size.width
        }
        set {
            self = CGRectMake(x, y, newValue, height)
        }
    }
    var height: CGFloat {
        get {
            return self.size.height
        }
        set {
            self = CGRectMake(x, y, width, newValue)
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