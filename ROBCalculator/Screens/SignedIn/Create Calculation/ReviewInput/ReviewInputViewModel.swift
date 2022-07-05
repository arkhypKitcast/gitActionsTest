//
//  ReviewInputViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 16.04.2022.
//

import Foundation
import Combine

class ReviewInputViewModel {
    let exitResponder: ExitFlowResponder
    let reviewResponder: CalculationReviewResponder
    
    init(exitResponder: ExitFlowResponder, reviewResponder: CalculationReviewResponder) {
        self.reviewResponder = reviewResponder
        self.exitResponder = exitResponder
    }
    
    @objc
    func closeFlow() {
        exitResponder.exitFlow()
    }

    func editQuestion(at index: Int) {
        reviewResponder.quickEditQuesstion(questions: StringQuestion(key: "1",
                                                                     title: "How much do you pay for a gallon of aviation fuel?",
                                                                     placeholder: nil,
                                                                     qDescription: "Hint: Input Hours to TBO",
                                                                     value: "nil"))
    }
    
    func approveQuestions() {
        reviewResponder.reviewApproved()
    }
}
