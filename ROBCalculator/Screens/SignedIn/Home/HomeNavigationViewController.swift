//
//  HomeNavigationViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import Foundation
import UIKit
import Combine

class HomeNavigationViewController: NiblessNavigationController {
    var cancellables = Set<AnyCancellable>()
    let viewModel: HomeNavigationViewModel
    let settingsFactory: () -> SettingsViewController
    let createCalculationViewController: ((CalculationType) -> UIViewController)
    
    init(viewModel: HomeNavigationViewModel,
         viewController: UIViewController,
         settingsFactory: @escaping () -> SettingsViewController,
         createCalculationViewController: @escaping ((CalculationType) -> UIViewController)
    ) {
        self.createCalculationViewController = createCalculationViewController
        self.settingsFactory = settingsFactory
        self.viewModel = viewModel
        super.init()

        self.viewControllers = [viewController]
        setupTabBarItem(named: "Home")
        subscribe()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = textAttributes
        navigationBar.tintColor = .white
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    func subscribe() {
        viewModel.$pushScreen
            .sink { [weak self] screen in
                self?.pushScreen(screen)
            }
            .store(in: &cancellables)
    }
    
    func pushScreen(_ type: HomeNavigationScreen) {
        switch type {
        case .settings:
            pushSettings()
        case .calculation(let type):
            presentCalculation(type: type)
        case .idle:
            break
        }
    }
    
    func pushSettings() {
        let vc = settingsFactory()
        vc.hidesBottomBarWhenPushed = true
        pushViewController(vc, animated: true)
    }
    
    func presentCalculation(type: CalculationType) {
        let vc = createCalculationViewController(type)
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        present(vc, animated: true)
    }
    
}
