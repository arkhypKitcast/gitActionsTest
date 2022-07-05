//
//  GradientView.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import UIKit

class GradientView: UIView {
    var colors: [UIColor] = [
        UIColor(red: 0.457, green: 0.634, blue: 0.974, alpha: 1),
        UIColor(red: 0.341, green: 0.475, blue: 0.949, alpha: 1)
    ]
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.shouldRasterize = true
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        
        self.layer.addSublayer(layer)
        return layer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map({ $0.cgColor })
    }
}
