//
//  UIImage+Extensions.swift
//  ROBCalculator
//
//  Created by arkhyp on 26.03.2022.
//

import Foundation
import UIKit

extension UIImage {
    
    class func tabBar() -> UIImage {
        let view = GradientView()
        view.frame = CGRect(x: 0, y: 0, width: 1, height: 3)
        view.colors = [
            UIColor.appBackground.withAlphaComponent(0),
            UIColor.appBackground
        ]
        view.gradientLayer.locations = [0, 1]
        view.gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        view.gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        view.gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 0, ty: 0))
    
        return view.asImage()
    }
    
    class func navBar() -> UIImage {
        let view = GradientView()
        view.frame = CGRect(x: 0, y: 0, width: 1, height: 10)
        view.colors = [
            UIColor.appBackground,
            UIColor.appBackground.withAlphaComponent(0)
        ]
        view.gradientLayer.locations = [0, 1]
        view.gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        view.gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        view.gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 0, ty: 0))
    
        return view.asImage()
    }
}
