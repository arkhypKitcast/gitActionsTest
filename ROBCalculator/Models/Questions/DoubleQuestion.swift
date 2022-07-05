//
//  DoubleQuestion.swift
//  ROBCalculator
//
//  Created by arkhyp on 28.04.2022.
//

import Foundation

class DoubleQuestion: Question {
    var value: Double?
    var measure: String?
    
    init(key: String, title: String, placeholder: String?, qDescription: String?, value: Double?, measure: String?) {
        self.value = value
        self.measure = measure
        super.init(key: key, title: title, placeholder: placeholder, qDescription: qDescription)
    }
}
