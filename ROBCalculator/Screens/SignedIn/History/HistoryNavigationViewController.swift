//
//  HistoryNavigationViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import Foundation
import UIKit

class HistoryNavigationViewController: NiblessNavigationController {
    let viewModel: HistoryNavigationViewModel
    
    init(viewModel: HistoryNavigationViewModel, viewController: UIViewController) {
        self.viewModel = viewModel
        super.init()
        
        self.viewControllers = [viewController]
        setupTabBarItem(named: "History")
    }
}
