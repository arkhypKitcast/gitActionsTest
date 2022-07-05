//
//  TemplateSelectorViewModel.swift
//  ROBCalculator
//
//  Created by arkhyp on 11.04.2022.
//

import Foundation
import Combine

class TemplateSelectorViewModel {

    @Published
    var state: Bool = false
    
    var filterString: String? = nil { didSet { filter() }}
    var templates: [CalculationTemplate] = []
    var allTemplates: [CalculationTemplate] = []
    
    let exitResponder: ExitFlowResponder
    let templateResponder: CalculationTemplateResponder
    let templateRepository: TemplatesRepository
    
    init(templateRepository: TemplatesRepository, exitResponder: ExitFlowResponder, templateResponder: CalculationTemplateResponder) {
        self.exitResponder = exitResponder
        self.templateResponder = templateResponder
        self.templateRepository = templateRepository
        fetchTemplates()
    }
    
    @objc
    func closeFlow() {
        exitResponder.exitFlow()
    }
    
    func selectAt(ind: Int) {
        let template = templates[ind]
        templateResponder.selectedCalculationTemplate(template: template)
    }
    
    func fetchTemplates() {
        allTemplates = templateRepository.getTemplates()
        filter()
    }
    
    func filter() {
        defer {
            state = true
        }
        
        guard let filter = filterString?.lowercased(), filter.isEmpty == false else {
            templates = allTemplates
            return
        }

        templates = allTemplates.filter({ $0.title.lowercased().contains(filter) })
    }
}
