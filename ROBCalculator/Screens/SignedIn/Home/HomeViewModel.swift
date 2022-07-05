//
//  HomeViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import Foundation
import Combine

class HomeViewModel {
    
    let settingsNavigator: GoToSettingsNavigator
    let calculationNavigator: GoToCreateCalculationNavigator
    
    @Published
    var calclationResults: [CalclationResult] = []
    
    init(settingsNavigator: GoToSettingsNavigator, calculationNavigator: GoToCreateCalculationNavigator) {
        self.settingsNavigator = settingsNavigator
        self.calculationNavigator = calculationNavigator
    }
    
    func openSettings() {
        settingsNavigator.navigateToSettings()
    }
    
    func openCalculation(type: CalculationType) {
        calculationNavigator.navigateToCreateCalculation(type: type)
    }
}

class CalclationResult {
    
}
