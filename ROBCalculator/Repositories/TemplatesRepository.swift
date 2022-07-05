//
//  TemplatesRepository.swift
//  ROBCalculator
//
//  Created by arkhyp on 22.04.2022.
//

import Foundation

protocol TemplatesRepository {
    func getTemplates() -> [CalculationTemplate]
}

class LocalTemplatesRepository: TemplatesRepository {
    let fReader = FileReader()
    
    init() {}
    
    func getTemplates() -> [CalculationTemplate] {
        let result: CalculationTemplatesResult? = fReader.readLocalFile(forName: "Templates")?.parseJson()
        return result?.templates ?? []
    }
}
