//
//  HomeNavigationViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import Foundation
import Combine

enum HomeNavigationScreen {
    case idle
    case settings
    case calculation(CalculationType)
}

class HomeNavigationViewModel: GoToSettingsNavigator, GoToCreateCalculationNavigator {
    
    @Published
    var pushScreen: HomeNavigationScreen = .idle
    
    func navigateToSettings() {
        pushScreen = .settings
    }
    
    func navigateToCreateCalculation(type: CalculationType) {
        pushScreen = .calculation(type)
    }
}
