//
//  CalculationNavigationViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 11.04.2022.
//

import Foundation
import Combine

enum CalculationNavigationScreen {
    case idle
    case exit
    
    case options
    case inputData
    case reviewData
    case quickEditQuestion
    case detail
}

class CalculationNavigationViewModel: ExitFlowResponder, CalculationOptionsResponder, CalculationTemplateResponder, CalculationInputResponder, CalculationReviewResponder, QuickEditQuestionResponder {
    
    @Published
    var pushScreen: CalculationNavigationScreen = .idle
    
    var template: CalculationTemplate?
    var option: CalculationOptions?
    var questions: [Question] = []
    var qEditQuestion: Question?
    
    func exitFlow() {
        pushScreen = .exit
    }
    
    func selectedCalculationOptions(option: CalculationOptions) {
        self.option = option
        self.pushScreen = .inputData
    }
    
    func selectedCalculationTemplate(template: CalculationTemplate) {
        self.template = template
        self.pushScreen = .options
    }
    
    func calculationDidInput(questions: [Question]) {
        self.questions = questions
        self.pushScreen = .reviewData
    }
    
    func quickEditQuesstion(questions: Question) {
        self.qEditQuestion = questions
        self.pushScreen = .quickEditQuestion
    }
    
    func reviewApproved() {
        self.pushScreen = .detail
    }
    
    func didEditQuestion(question: Question) {
        
    }
}
