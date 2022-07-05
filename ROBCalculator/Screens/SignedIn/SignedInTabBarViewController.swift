//
//  SignedInTabBarViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 22.03.2022.
//

import Foundation
import UIKit

class SignedInTabBarViewController: NiblessTabBarController {
    let viewModel: SignedInTabBarViewModel
    
    init(viewModel: SignedInTabBarViewModel, viewControllers: [UIViewController]) {
        self.viewModel = viewModel
        super.init()
        
        self.viewControllers = viewControllers
    }
}
