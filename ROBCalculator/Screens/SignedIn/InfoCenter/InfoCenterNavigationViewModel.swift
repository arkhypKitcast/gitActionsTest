//
//  InfoCenterNavigationViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import Foundation
import Combine

class InfoCenterNavigationViewModel: GoToDictionaryNavigator {
    @Published
    var presentDictionary: Bool = false
    
    func navigateToDictionary() {
        presentDictionary = true
    }
}
