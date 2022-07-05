//
//  CalculationInputViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 13.04.2022.
//

import Foundation
import Combine

class CalculationInputViewModel {
    
    let exitResponder: ExitFlowResponder
    let calculationInputResponder: CalculationInputResponder
    
    let questions: [Question]
    
    var currentInd: Int = 0
    
    @Published
    var currentQuestion: Question?
    
    @Published
    var completionText: String? = ""
    
    @Published
    var progress: Float = 0.0
    
    @Published
    var backIsHidden: Bool = false
    
    @Published
    var nextIsHidden: Bool = false
    
    @Published
    var nextIsEnabled: Bool = false
    
    
    init(exitResponder: ExitFlowResponder, calculationInputResponder: CalculationInputResponder, questions: [Question]) {
        self.questions = questions
        self.exitResponder = exitResponder
        self.calculationInputResponder = calculationInputResponder
        updateCurrentQuestion()
        updateNavigationButtons()
        updateProgressLabels()
    }
    
    @objc
    func closeFlow() {
        exitResponder.exitFlow()
    }
    
    @objc
    func goNext() {
        guard questions.count > currentInd + 1 else {
            calculationInputResponder.calculationDidInput(questions: questions)
            return
        }
        
        currentInd += 1
        updateCurrentQuestion()
        updateNavigationButtons()
        updateProgressLabels()
    }
    
    @objc
    func goPrevious() {
        guard currentInd - 1 >= 0 else {
            return
        }
        
        currentInd -= 1
        updateCurrentQuestion()
        updateNavigationButtons()
        updateProgressLabels()
    }
    
    func updateCurrentQuestion() {
        currentQuestion = questions[currentInd]
    }
    
    func updateNavigationButtons() {
        backIsHidden = currentInd == 0
        nextIsEnabled = questions[currentInd].isAnswered
    }
    
    func updateProgressLabels() {
        completionText = "Question \(currentInd + 1) of \(questions.count)"
        progress = Float(currentInd) / Float(questions.count)
    }
}
