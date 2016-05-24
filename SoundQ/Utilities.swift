//
//  Utilities.swift
//  SoundQ
//
//  Created by Nishil Shah on 5/16/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import Foundation
import UIKit

struct Utilities {
    
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        let newRect = CGRectIntegral(CGRectMake(0,0, newSize.width, newSize.height))
        let imageRef = image.CGImage
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        // Set the quality level to use when rescaling
        CGContextSetInterpolationQuality(context, CGInterpolationQuality.High)
        let flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height)
        
        CGContextConcatCTM(context, flipVertical)
        // Draw into the context; this scales the image
        CGContextDrawImage(context, newRect, imageRef)
        
        let newImageRef = CGBitmapContextCreateImage(context)! as CGImage
        let newImage = UIImage(CGImage: newImageRef)
        
        // Get the resized image from the context and a UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func drawRectangleOnImage(image: UIImage) -> UIImage {
        //begin graphics
        let imageSize = image.size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        image.drawAtPoint(CGPointZero)
        
        //draw rectangle
        let rectangle = CGRect(x: 0, y: (imageSize.height/2) - 30, width: imageSize.width, height: 60)
        let rectangleColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        rectangleColor.setFill()
        UIRectFillUsingBlendMode(rectangle, CGBlendMode.Normal)
        
        //return new image
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}