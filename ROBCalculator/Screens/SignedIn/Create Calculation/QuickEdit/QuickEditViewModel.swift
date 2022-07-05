//
//  QuickEditViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 17.04.2022.
//

import Foundation

class QuickEditViewModel {
    let question: Question
    let editResponder: QuickEditQuestionResponder
    
    init(question: Question, editResponder: QuickEditQuestionResponder) {
        self.editResponder = editResponder
        self.question = question
    }
    
    func approveQuestion() {
        editResponder.didEditQuestion(question: question)
    }
}
