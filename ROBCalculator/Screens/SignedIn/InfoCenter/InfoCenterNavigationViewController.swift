//
//  InfoCenterNavigationViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import Combine
import UIKit

class InfoCenterNavigationViewController: NiblessNavigationController {
    var cancellables = Set<AnyCancellable>()
    let viewModel: InfoCenterNavigationViewModel
    
    let makeDictionaryViewController: (() -> UIViewController)
    
    init(
        viewModel: InfoCenterNavigationViewModel,
        viewController: UIViewController,
        makeDictionaryViewController: @escaping (() -> UIViewController)
    ) {
        self.makeDictionaryViewController = makeDictionaryViewController
        self.viewModel = viewModel
        super.init()

        self.viewControllers = [viewController]
        setupTabBarItem(named: "Info Center")
        subscribe()
    }
    
    func subscribe() {
        viewModel.$presentDictionary
            .dropFirst()
            .sink { [weak self] _ in
                self?.pushDictionary()
            }
            .store(in: &cancellables)
    }
    
    func pushDictionary() {
        let vc = makeDictionaryViewController()
        pushViewController(vc, animated: true)
    }
}
