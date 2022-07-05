//
//  UINavigationController+Extensions.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import Foundation
import UIKit

extension UINavigationController {
    func setupTabBarItem(named: String) {
        let icnName = named.filter {!$0.isWhitespace}
        tabBarItem.selectedImage = UIImage(named: "\(icnName)Icn_selected")//?.withRenderingMode(.alwaysOriginal)
        tabBarItem.image = UIImage(named: "\(icnName)Icn")//?.withRenderingMode(.alwaysOriginal)
        tabBarItem.title = named
    }
}
