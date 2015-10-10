//
//  StarView.swift
//  Starry
//
//  Created by Chris Stroud on 10/9/15.
//  Copyright © 2015 HackNC. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class StarView:UIView {
    
    var ratingIndex:Int = 3 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var editable:Bool = false
    
    private var starRegions:[CGRect] = []
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let dimension = min(rect.width, rect.height) - 8.0
        let starPath = UIBezierPath.starPathForSize(CGSizeMake(dimension, dimension))
        let startX = Float(rect.midX - (starPath.bounds.width * 5) * 0.5 - 16)
        let startY = Float(rect.midY - starPath.bounds.height * 0.5)
        
        starPath.translate(startX, y:startY)
        starRegions.removeAll()
        for index in 0..<5 {
            if index > 0 {
                starPath.translate(Float(starPath.bounds.width + 8.0), y: 0)
            }
            starRegions.append(starPath.bounds.insetBy(dx: -16, dy: 0))
            self.tintColor.set()
            if index < ratingIndex {
                starPath.fill()
            } else {
                starPath.lineWidth = 2.0
                starPath.stroke()
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        if let pt = touches.first?.locationInView(self) where self.editable == true {
            self.updateStars(pt)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        if let pt = touches.first?.locationInView(self) where self.editable == true {
            self.updateStars(pt)
        }
    }
    
    private func updateStars(pt:CGPoint) {
        
        var newIndex = 0
        for (index, rect) in self.starRegions.enumerate() {
            if rect.contains(pt) {
                newIndex = index + 1
            }
        }
        self.ratingIndex = newIndex
    }
}