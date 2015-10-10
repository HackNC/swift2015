//
//  Extensions.swift
//  Starry
//
//  Created by Chris Stroud on 10/9/15.
//  Copyright © 2015 HackNC. All rights reserved.
//

import Foundation
import UIKit

extension UIBezierPath {
    func translate(x:Float, y:Float) {
        self.applyTransform(CGAffineTransformMakeTranslation(CGFloat(x), CGFloat(y)))
    }
}

extension UIBezierPath {
    class func starPathForSize(size:CGSize) -> UIBezierPath {
        
        let originalSize = CGSizeMake(70, 70)
        let originalPoints:[(x:CGFloat, y:CGFloat)] = [
            (x:35, y:0),
            (x:47.34, y:18.01),
            (x:68.29, y:24.18),
            (x:54.97, y:41.49),
            (x:55.57, y:63.32),
            (x:35, y:56),
            (x:14.43, y:63.32),
            (x:15.03, y:41.49),
            (x:1.71, y:24.18),
            (x:22.66, y:18.01)
        ]
        
        let scalablePoints = originalPoints.map{(x:$0.x/originalSize.width, y:$0.y / originalSize.height)}
        
        let minDimension = min(size.width, size.height)
        let points = scalablePoints.map{ point in
            CGPointMake(point.x * minDimension, point.y * minDimension)
        }
        
        let starPath = UIBezierPath()
        for (index, pt) in points.enumerate() {
            if index == 0 {
                starPath.moveToPoint(pt)
            } else {
                starPath.addLineToPoint(pt)
            }
        }
        
        starPath.closePath()
        return starPath
    }
}

extension NSFileManager {
    static var documentsURL:NSURL {
        let fileManager = NSFileManager.defaultManager()
        return fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last!
    }
}