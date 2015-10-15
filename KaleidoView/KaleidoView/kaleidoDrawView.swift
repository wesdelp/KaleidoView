//
//  kaleidoDrawView.swift
//  KaleidoView
//
//  Created by Wesley Delp on 10/13/15.
//  Copyright © 2015 wesdelp. All rights reserved.
//

import UIKit

class kaleidoDrawView: UIView {
    // Rectangle Bounds
    var rectWidth    :CGFloat = 10.0 // Placeholder value
    var rectHeight   :CGFloat = 20.0 // Placeholder value
    var minRectWidth :CGFloat = 5.0  // Bounds for random
    var maxRectWidth :CGFloat = 80.0 // ...
    var minRectHeight:CGFloat = 5.0  // ...
    var maxRectHeight:CGFloat = 80.0 // ...
    
    // Rectangle Border stroke width
    var borderLineWidth:CGFloat = 5.0
    
    // Rectangle Color Bounds
    var minColor:CGFloat = 0.1
    var maxColor:CGFloat = 1.0
    var minAlpha:CGFloat = 0.1
    var maxAlpha:CGFloat = 0.8
    
    // Draw Speed
    var drawDelay:NSTimeInterval = 0.5
    
    // Layer to retain
    var drawLayer:CGLayerRef? = nil
    
    // Timer to stop and stop
    var drawTimer:NSTimer? = nil
    
    override func drawRect(rect:CGRect) {
        // Get drawing context
        let context = UIGraphicsGetCurrentContext()
        
        if (drawLayer == nil) {
            // Create Layer
            let size = CGSizeMake(self.bounds.size.width, self.bounds.height)
            drawLayer = CGLayerCreateWithContext(context, size, nil)
        }
        
        self.drawToLayer()
        
        CGContextDrawLayerInRect(context, self.bounds, drawLayer)
    }
    
    func drawToLayer() {
        // View Bounds
        let viewWidth :CGFloat = self.bounds.size.width
        let viewHeight:CGFloat = self.bounds.size.height
        
        
        // Generate Random Rect Size
        let rectWidth = getRandomFromFloatMin(minRectWidth, thruFloatMax:maxRectWidth)
        let rectHeight =  getRandomFromFloatMax(minRectHeight, thruFloatMax:maxRectHeight)
        
        // Get Random Centroid for 4 Rects
        let centroidX = getRandomFromFloatMin(borderLineWidth, thruFloatMax: viewWidth - rectWidth - borderLineWidth)
        let centroidY
    }
}
