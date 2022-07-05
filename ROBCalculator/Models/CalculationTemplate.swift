//
//  CalculationTemplate.swift
//  ROBCalculator
//
//  Created by arkhyp on 13.04.2022.
//

import Foundation

struct CalculationTemplatesResult: Codable {
    let templates: [CalculationTemplate]
}

struct CalculationTemplate: Codable {
    let id: Int
    let title: String
    let image: String
}
