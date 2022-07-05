//
//  CalculatorOptionsViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 11.04.2022.
//

import Foundation
import Combine

class CalculatorOptionsViewModel {
    
    @Published
    var isValid: Bool = false
    
    var isOperating: Bool = false { didSet { validate() }}
    var isOwnership: Bool = false { didSet { validate() }}
    var isOwnershipFinancing: Bool = false { didSet { validate() }}
    
    let exitResponder: ExitFlowResponder
    let optionsResponder: CalculationOptionsResponder
    
    init(exitResponder: ExitFlowResponder, optionsResponder: CalculationOptionsResponder) {
        self.exitResponder = exitResponder
        self.optionsResponder = optionsResponder
    }
    
    @objc
    func closeFlow() {
        exitResponder.exitFlow()
    }
    
    @objc
    func goToInput() {
        let option = CalculationOptions(operating: isOperating,
                                       ownership: isOwnership,
                                       financing: isOwnershipFinancing)
        optionsResponder.selectedCalculationOptions(option: option)
    }
    
    func validate() {
        isValid = isOperating || isOwnership
    }
}

