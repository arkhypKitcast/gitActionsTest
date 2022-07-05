//
//  Question.swift
//  ROBCalculator
//
//  Created by arkhyp on 28.04.2022.
//

import Foundation

class Question {
    var key: String?
    var title: String?
    var placeholder: String?
    var qDescription: String?
    
    var isAnswered: Bool {
        return true
    }
    
    init(key: String, title: String, placeholder: String?, qDescription: String?) {
        self.key = key
        self.title = title
        self.placeholder = placeholder
        self.qDescription = qDescription
    }
}
