//
//  CalculationNavigationViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 11.04.2022.
//

import Foundation
import UIKit
import Combine

enum CalculationType {
    case new
    case template
}

class CalculationNavigationViewController: NiblessNavigationController {
    var cancellables = Set<AnyCancellable>()
    let viewModel: CalculationNavigationViewModel
        
    let optionSelectorFactory: (() -> UIViewController)
    let calculationInputFactory: (([Question]) -> UIViewController)
    let calculationReviewFactory: (() -> UIViewController)
    let quickEditReviewFactory: ((Question) -> UIViewController)
    let detailViewFactory: (() -> UIViewController)
    
    init(viewModel: CalculationNavigationViewModel,
         viewController: UIViewController,
         optionSelectorFactory: @escaping (() -> UIViewController),
         calculationInputFactory: @escaping (([Question]) -> UIViewController),
         calculationReviewFactory: @escaping (() -> UIViewController),
         quickEditReviewFactory: @escaping ((Question) -> UIViewController),
         detailViewFactory: @escaping (() -> UIViewController)
    ) {
        self.optionSelectorFactory = optionSelectorFactory
        self.calculationInputFactory = calculationInputFactory
        self.calculationReviewFactory = calculationReviewFactory
        self.quickEditReviewFactory = quickEditReviewFactory
        self.detailViewFactory = detailViewFactory
        self.viewModel = viewModel
        super.init()

        self.viewControllers = [viewController]
        subscribe()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func subscribe() {
        viewModel.$pushScreen
            .sink { [weak self] screen in
                self?.pushScreen(screen)
            }
            .store(in: &cancellables)
    }
    
    func pushScreen(_ type: CalculationNavigationScreen) {
        switch type {
        case .exit:
            closeFlow()
        case .idle:
            break
        case .options:
            pushOptionSelector()
        case .inputData:
            pushInputData()
        case .reviewData:
            pushReviewData()
        case .quickEditQuestion:
            presentQuickEdit()
        case .detail:
            pushReviewDetail()
        }
    }
    
    func closeFlow() {
        dismiss(animated: true)
    }
    
    func pushOptionSelector() {
        let vc = optionSelectorFactory()
        pushViewController(vc, animated: true)
    }
    
    func pushInputData() {
        let vc = calculationInputFactory(viewModel.option?.questions ?? [])
        pushViewController(vc, animated: true)
    }
    
    func pushReviewData() {
        let vc = calculationReviewFactory()
        pushViewController(vc, animated: true)
    }
    
    func presentQuickEdit() {
        guard let question = viewModel.qEditQuestion else { return }
        let vc = quickEditReviewFactory(question)
        present(vc, animated: true)
    }
    
    func pushReviewDetail() {
        let vc = detailViewFactory()
        pushViewController(vc, animated: true)
    }
}
