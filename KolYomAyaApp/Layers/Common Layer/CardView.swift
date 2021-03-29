//
//  CardView.swift
//  TestAbo
//
//  Created by Staff on 8/27/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit



@IBDesignable class CardView: UIView {

    @IBInspectable var cornerradius : CGFloat = 4

    @IBInspectable var shadowoffestWidth : CGFloat = 0
    
    @IBInspectable var shadowOffSwtHight : CGFloat = 5
    
    
    @IBInspectable var shadowColor : UIColor = UIColor(displayP3Red: 214, green: 214, blue: 214, alpha: 0.14)
    
    @IBInspectable var shadowOpacity : CGFloat = 0.5
    
    
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornerradius
        
        layer.shadowColor = shadowColor.cgColor
        
        layer.shadowOffset = CGSize(width: shadowoffestWidth, height: shadowOffSwtHight)
        
            let shadowpath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        
        layer.shadowPath = shadowpath.cgPath
        
        layer.shadowOpacity = Float(shadowOpacity)

    }

}
