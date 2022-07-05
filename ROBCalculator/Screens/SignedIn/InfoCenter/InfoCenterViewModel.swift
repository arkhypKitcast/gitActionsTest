//
//  InfoCenterViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 10.04.2022.
//

import Foundation

class InfoCenterViewModel {
    let dictNavigator: GoToDictionaryNavigator
    
    init(dictNavigator: GoToDictionaryNavigator) {
        self.dictNavigator = dictNavigator
    }
    
    func showDictionary() {
        dictNavigator.navigateToDictionary()
    }
}
