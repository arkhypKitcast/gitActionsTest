//
//  OnboardingNavigation.swift
//  ROBCalculator
//
//  Created by arkhyp on 22.03.2022.
//

import Foundation
import UIKit

class OnboardingNavigation: NiblessNavigationController {
    let welcome: WelcomeViewController
    
    init(welcome: WelcomeViewController) {
        self.welcome = welcome
        super.init()
        viewControllers = [welcome]
    }
}
