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
    var maxRectWidth :CGFloat = 30.0 // ...
    var minRectHeight:CGFloat = 5.0  // ...
    var maxRectHeight:CGFloat = 30.0 // ...
    
    // Rectangle Border stroke width
    var borderLineWidth:CGFloat = 5.0
    
    // Rectangle Color Bounds
    var minColor:CGFloat = 0.1
    var maxColor:CGFloat = 1.0
    var minAlpha:CGFloat = 0.1
    var maxAlpha:CGFloat = 0.8
    var useAlpha         = false
    
    // Draw Speed
    var drawDelay:NSTimeInterval = 0.1
    
    // Layer to retain
    var drawLayer:CGLayerRef? = nil
    
    // Timer to stop and stop
    var drawTimer:NSTimer? = nil
    
    override func drawRect(rect:CGRect) {
        // Get drawing context
        let context = UIGraphicsGetCurrentContext()
        
        if (drawLayer == nil) {
            // Create Layer
            let size = CGSizeMake(self.bounds.size.width, self.bounds.size.height)
            drawLayer = CGLayerCreateWithContext(context, size, nil)
        }
        
        self.drawToLayer()
        
        CGContextDrawLayerInRect(context, self.bounds, drawLayer)
    }
    
    func drawToLayer() {
        // View Bounds
        let viewWidth :CGFloat = self.bounds.size.width
        let viewHeight:CGFloat = self.bounds.size.height
        
        // Create the color
        let color = getRandomColor()
        
        // Generate Random Rect Size
        let rectWidth = getRandomFromFloatMin(minRectWidth, thruFloatMax:maxRectWidth)
        let rectHeight = getRandomFromFloatMin(minRectHeight, thruFloatMax:maxRectHeight)
        
        // Get Random Centroid for 4 Rects
        let centroidX = viewWidth/2
        print("X=\(centroidX)")
                        //getRandomFromFloatMin(borderLineWidth,
                        //thruFloatMax: viewWidth - rectWidth - borderLineWidth)
        let centroidY = viewHeight/2
        print("Y=\(centroidY)")
                        //getRandomFromFloatMin(borderLineWidth,
                        //thruFloatMax: viewHeight - rectHeight - borderLineWidth)
        
        let offsetX = getRandomFromFloatMin(borderLineWidth,
                              thruFloatMax: viewWidth - rectWidth - borderLineWidth - centroidX)
        let offsetY = getRandomFromFloatMin(borderLineWidth,
                              thruFloatMax: viewHeight - rectHeight - borderLineWidth - centroidY)
        
        let adjustOriginX = rectWidth/2
        
        let adjustOriginY = rectHeight/2
        
        let rectLocations = [
                            CGRect(x:centroidX + offsetX - adjustOriginX, y:centroidY + offsetY - adjustOriginY,
                                width:rectWidth, height:rectHeight),
                            CGRect(x:centroidX - offsetX - adjustOriginX, y:centroidY - offsetY - adjustOriginY,
                                width:rectWidth, height:rectHeight),
                            CGRect(x:centroidX + offsetX - adjustOriginX, y:centroidY - offsetY - adjustOriginY,
                                width:rectWidth, height:rectHeight),
                            CGRect(x:centroidX - offsetX - adjustOriginX, y:centroidY + offsetY - adjustOriginY,
                                width:rectWidth, height:rectHeight)
                            ]
        
        drawRectangles(rectLocations, withColor:color)
    }
    
    func drawRectangles(rectLocations:[CGRect], withColor color:UIColor) {
        let layerContext = CGLayerGetContext(drawLayer)
    
        CGContextSetLineWidth(layerContext, borderLineWidth)
    
        var red   : CGFloat = 0.0
        var green : CGFloat = 0.0
        var blue  : CGFloat = 0.0
        var alpha : CGFloat = 0.0
        color.getRed(&red, green:&green, blue:&blue, alpha:&alpha)
    
        CGContextSetRGBFillColor(layerContext, red, green, blue, alpha)
        CGContextSetRGBStrokeColor(layerContext, red, green, blue, alpha)
    
        for rect in rectLocations {
            CGContextAddRect(layerContext, rect)
            CGContextDrawPath(layerContext, .Fill)
        }
    }
    
    func startDrawing() {
        drawTimer = NSTimer(timeInterval: drawDelay,
            target: self,
            selector: Selector("setNeedsDisplay"),
            userInfo: nil,
            repeats: true)
        let runLoop = NSRunLoop.currentRunLoop()
        runLoop.addTimer(drawTimer!, forMode: "NSDefaultRunLoopMode")
    }
    
    func stopDrawing() {
        if let drawTimer2 = drawTimer
        {
            drawTimer2.invalidate()
        }
        self.drawTimer = nil
    }
    
    func getRandomColor() -> UIColor {
        let red   = getRandomFromFloatMin(minColor, thruFloatMax: maxColor)
        let green = getRandomFromFloatMin(minColor, thruFloatMax: maxColor)
        let blue  = getRandomFromFloatMin(minColor, thruFloatMax: maxColor)
        var alpha : CGFloat = 100.0
        
        if useAlpha {
            alpha = getRandomFromFloatMin(minAlpha, thruFloatMax: maxAlpha)
        }
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        return color
    }
    
    func getRandomFromIntMin(min: Int, thruIntMax max: Int)-> CGFloat {
        let randomNum = Int(arc4random() / 2)
        
        let randomInRange = CGFloat(randomNum % (max - min) + min)
        
        return randomInRange
    }
    
    func getRandomFromFloatMin(min: CGFloat, thruFloatMax max: CGFloat) -> CGFloat {
        // Three decimal places
        let accuracy : CGFloat = 1000.0
        
        let scaledMin : CGFloat = min * accuracy
        let scaledMax : CGFloat = max * accuracy
        
        // arc4random returns unsigned 64 bit value, so divide by 2
        let randomNum = Int(arc4random() / 2)
        
        // Put the value in the specified range of values
        let randomInRange = CGFloat(randomNum % Int(scaledMax - scaledMin)) / accuracy + min
        
        return randomInRange
    }
    
    
}
