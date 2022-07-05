//
//  StringQuestion.swift
//  ROBCalculator
//
//  Created by arkhyp on 28.04.2022.
//

import Foundation

class StringQuestion: Question {
    var value: String?
    
    init(key: String, title: String, placeholder: String?, qDescription: String?, value: String?) {
        self.value = value
        super.init(key: key, title: title, placeholder: placeholder, qDescription: qDescription)
    }
}
