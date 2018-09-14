//
//  RadialGradientView.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 13.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import UIKit

@IBDesignable
class RadialGradientView: UIView {
    
    @IBInspectable var InsideColor: UIColor = UIColor.clear
    @IBInspectable var OutsideColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        let colors = [InsideColor.cgColor, OutsideColor.cgColor] as CFArray
        let endRadius = min(frame.width, frame.height) / 2
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        UIGraphicsGetCurrentContext()!.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    }
}
