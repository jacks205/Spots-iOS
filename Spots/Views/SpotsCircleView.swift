//
//  SpotsCircleView.swift
//  Spots
//
//  Created by Mark Jackson on 4/4/16.
//  Copyright © 2016 Mark Jackson. All rights reserved.
//
import UIKit

@IBDesignable class SpotsCircleView: UIView {
    
    @IBInspectable var baseColor : UIColor?
    var fillColor : UIColor = SpotsAppearance.Circle.Green
    
    private var amountFilled : CGFloat = 25
    
    var circleLayer : CAShapeLayer?
    var firstPath : UIBezierPath?
    var secondPath : UIBezierPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        circleLayer = CAShapeLayer()
        layer.addSublayer(circleLayer!)
        firstPath = UIBezierPath(ovalInRect: CGRectInset(bounds, bounds.width / 2, bounds.height / 2))
        secondPath = UIBezierPath(ovalInRect: CGRectInset(bounds, 0, 0))
    }
    
    func animateCircle(delay: CFTimeInterval) {
        if let cl = circleLayer {
            cl.frame = bounds
            cl.fillColor = fillColor.CGColor
            if let fp = firstPath {
                cl.path = fp.CGPath
            }
            let anim : CABasicAnimation = CABasicAnimation(keyPath: "path")
            anim.duration = 0.35
            if let sp = secondPath {
                anim.toValue = sp.CGPath
            }
            anim.removedOnCompletion = false
            anim.fillMode = kCAFillModeBoth
            anim.beginTime = CACurrentMediaTime() + delay
            
            anim.timingFunction = CAMediaTimingFunction(controlPoints: 0.23, 1.0, 0.32, 1.0)
            cl.addAnimation(anim, forKey: anim.keyPath)
            
        }
        
        
    }
    
    func setCapacityLevel(currentCapacity : CGFloat, outOfTotalCapacity totalCapacity : CGFloat) {
        let percentage = currentCapacity / totalCapacity
        amountFilled = (1 - percentage) * bounds.width / 2
        if percentage < 0.1 {
            amountFilled = 0.9 * bounds.width / 2
        }
        if 1 - percentage >= 0.85 {
            fillColor = SpotsAppearance.Circle.Red
        } else if 1 - percentage >= 0.55 {
            fillColor = SpotsAppearance.Circle.Yellow
        } else {
            fillColor = SpotsAppearance.Circle.Green
        }
        secondPath = UIBezierPath(ovalInRect: CGRectInset(bounds, amountFilled, amountFilled))
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        //Outer Circle
        let outerColor : UIColor = baseColor!
        outerColor.setFill()
        let basePath : UIBezierPath = UIBezierPath(ovalInRect: CGRectInset(rect, 1, 1))
        basePath.fill()
        
        //Inner circle
        let innerColor : UIColor = fillColor
        if let cl = circleLayer {
            cl.frame = bounds
            cl.fillColor = innerColor.CGColor
            cl.path = firstPath!.CGPath
        }
    }
    
    
}
