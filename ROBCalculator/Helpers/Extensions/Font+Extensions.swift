//
//  Font+Extensions.swift
//  ROBCalculator
//
//  Created by arkhyp on 02.03.2022.
//

import Foundation
import UIKit

public extension UIFont {
    static var title: UIFont {
        return appFont(ofSize: 56, weight: .bold)
    }
    
    static var title1: UIFont {
        return appFont(ofSize: 32, weight: .bold)
    }
    
    static var title2: UIFont {
        return appFont(ofSize: 24, weight: .bold)
    }

    static var title3: UIFont {
        return appFont(ofSize: 18, weight: .bold)
    }
    
    static var headline: UIFont {
        return appFont(ofSize: 16, weight: .semibold)
    }
    
    static var body: UIFont {
        return appFont(ofSize: 17, weight: .regular)
    }
    
    static var bodySemibold: UIFont {
        return appFont(ofSize: 17, weight: .semibold)
    }

    static var callout: UIFont {
        return appFont(ofSize: 14, weight: .regular)
    }
    
    static var calloutSemibold: UIFont {
        return appFont(ofSize: 14, weight: .semibold)
    }

    static var footnote: UIFont {
        return appFont(ofSize: 12, weight: .regular)
    }
    
    static var footnoteSemibold: UIFont {
        return appFont(ofSize: 12, weight: .semibold)
    }
    
    static var caption1: UIFont {
        return appFont(ofSize: 11, weight: .regular)
    }
    
    static var caption1Semibold: UIFont {
        return appFont(ofSize: 11, weight: .semibold)
    }
    
    static var caption2: UIFont {
        return appFont(ofSize: 10, weight: .regular)
    }
    
    static var caption2Medium: UIFont {
        return appFont(ofSize: 10, weight: .medium)
    }
    
    static func appFont(ofSize: CGFloat, weight: Weight = .regular) -> UIFont {
        return .systemFont(ofSize: ofSize, weight: weight)
    }

    private static func rawWeight(_ weight: Weight = .regular) -> String {
        switch weight {
        case .black:
            return "Black"
        case .ultraLight:
            return "UltraLight"
        case .bold:
            return "Bold"
        case .thin:
            return "Thin"
        case .semibold:
            return "SemiBold"
        case .regular:
            return "Regular"
        case .medium:
            return "Medium"
        case .light:
            return "Light"
        case .heavy:
            return "Heavy"
        default:
            return "Regular"
        }
    }
}
