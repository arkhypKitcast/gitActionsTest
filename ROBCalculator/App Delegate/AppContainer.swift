//
//  AppContainer.swift
//  ROBCalculator
//
//  Created by arkhyp on 02.03.2022.
//

import Foundation
import UIKit

class AppContainer {
    
    let sharedMainViewModel = MainViewModel()
    
    public init() {
        
    }
    
    public func makeMainViewController() -> MainViewController {

        let onboardingFactory = {
            return self.makeOnboarding()
        }
        
        let signedInFactory = {
            return self.makeSignedIn()
        }

        return MainViewController(
            viewModel: sharedMainViewModel,
            onboardingnNavigationFactory: onboardingFactory,
            makeSignedInNavigationFactory: signedInFactory)
    }
    
    func makeOnboarding() -> OnboardingNavigation {
        return OnboardingNavigation(welcome: makeWelcomeScreen())
    }
    
    func makeSignedIn() -> SignedInTabBarViewController {
        let signedInContainer = SignedInContainer(appContainer: self)
        return signedInContainer.makeSignedInTabBarViewControllerViewController()
    }
    
    func makeWelcomeScreen() -> WelcomeViewController {
        let vm = WelcomeViewModel(signedInResponder: sharedMainViewModel)
        let vc = WelcomeViewController(viewModel: vm)
        return vc
    }
}
