//
//  EmptyCircleView.swift
//  Spots
//
//  Created by Mark Jackson on 4/4/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//

import UIKit

@IBDesignable class EmptyCircleView: UIView {
    
    @IBInspectable var lineColor : UIColor = UIColor(white: 1, alpha: 0.09)
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let clip : UIBezierPath = UIBezierPath(ovalInRect: CGRectInset(rect, 6, 6))
        clip.addClip()
        lineColor.setStroke()
        let path : UIBezierPath = UIBezierPath()
        path.lineWidth = 1
        let increments: CGFloat = rect.height / 8
        var j: CGFloat = increments
        for _ in 0...8 {
            path.moveToPoint(CGPoint(x: j, y: 0))
            path.addLineToPoint(CGPoint(x: j, y: rect.height))
            j += increments
            
        }
        path.stroke()
        
        self.transform = CGAffineTransformMakeRotation(CGFloat(-1 * M_PI_4))
        
    }
    
}
