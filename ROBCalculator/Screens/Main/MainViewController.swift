//
//  MainViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 22.03.2022.
//

import Foundation
import UIKit
import Combine

public class MainViewController: NiblessViewController {
    
    let viewModel: MainViewModel
    var stateCancellable: AnyCancellable?
    
    var currentVC: UIViewController?
    
    // Factories
    let makeOnboardingNavigation: () -> OnboardingNavigation
    let makeSignedInNavigation: () -> SignedInTabBarViewController
    
    public override var childForStatusBarStyle: UIViewController? {
        return currentVC
    }
    
    init(viewModel: MainViewModel,
                onboardingnNavigationFactory: @escaping () -> OnboardingNavigation,
                makeSignedInNavigationFactory: @escaping () -> SignedInTabBarViewController
    ) {
        self.viewModel = viewModel
        self.makeOnboardingNavigation = onboardingnNavigationFactory
        self.makeSignedInNavigation = makeSignedInNavigationFactory
        super.init()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currentVC?.view.frame = view.bounds
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func observeViewModel() {
        stateCancellable = viewModel.$state
            .removeDuplicates()
            .sink { [weak self] value in
                self?.presentView(value)
            }
    }
    
    private func presentView(_ state: MainViewState) {
        switch state {
        case .onboarding:
            presentOnboarding()
        case .signedIn:
            presentSignedIn()
        default:
            ()
        }
    }
    
    func setChildViewController(newChildVC: UIViewController) {
        addChildViewController(intoView: view, viewController: newChildVC)
        
        if let disappearVC = currentVC {
            let appearVC = newChildVC
            appearVC.view.transform = CGAffineTransform.init(translationX: 0, y: appearVC.view.bounds.height)
            UIView.animate(withDuration: 0.3) {
                appearVC.view.transform = .identity
            } completion: { [weak self] compl in
                self?.removeChildViewController(viewController: disappearVC)
                self?.currentVC = appearVC
            }
        } else {
            currentVC = newChildVC
        }
    }
    
    func removeViewController(oldChildVC: UIViewController) {
        removeChildViewController(viewController: oldChildVC)
    }
    
    private func presentOnboarding() {
        let onboardingVC = self.makeOnboardingNavigation()
        setChildViewController(newChildVC: onboardingVC)
    }

    func presentSignedIn() {
        let signedInVC = self.makeSignedInNavigation()
        setChildViewController(newChildVC: signedInVC)
    }
}

extension UIViewController {
    func addChildViewController(intoView: UIView, viewController: UIViewController) {
        addChild(viewController)
        viewController.view.frame = intoView.bounds
        intoView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func removeChildViewController(viewController: UIViewController) {
        viewController.removeFromParent()
        viewController.view.removeFromSuperview()
        viewController.didMove(toParent: nil)
    }
}
