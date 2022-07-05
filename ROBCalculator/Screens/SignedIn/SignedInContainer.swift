//
//  SignedInContainer.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import Foundation
import UIKit

public class SignedInContainer {

  // MARK: - Properties
    
  // MARK: - Methods
    init(appContainer: AppContainer) {}
    
    func makeSignedInTabBarViewControllerViewController() -> SignedInTabBarViewController {
        let viewModel = SignedInTabBarViewModel()
    
        return SignedInTabBarViewController(
            viewModel: viewModel,
            viewControllers: [
                makeHomeViewController(),
                makeHistoryViewController(),
                makeInfoCenterViewController()
            ])
    }
    
    func makeHomeViewController() -> UIViewController {
        
        let viewModel = HomeNavigationViewModel()
        
        let settingsFactory = {
            return self.makeSettingsViewController()
        }
        
        let calculatorFactory: (CalculationType) -> UIViewController = { type in
            return self.makeCalculationNavigationView(type: type)
        }
        
        let homeViewModel = HomeViewModel(settingsNavigator: viewModel, calculationNavigator: viewModel)
        let vc = HomeViewController(viewModel: homeViewModel)
        
        return HomeNavigationViewController(
            viewModel: viewModel,
            viewController: vc,
            settingsFactory: settingsFactory,
            createCalculationViewController: calculatorFactory
        )
    }
    
    func makeHistoryViewController() -> UIViewController {
        let vc = HistoryViewController(viewModel: HistoryViewModel())
        
        let viewModel = HistoryNavigationViewModel()
        return HistoryNavigationViewController(
            viewModel: viewModel,
            viewController: vc
        )
    }
    
    func makeInfoCenterViewController() -> UIViewController {
        let viewModel = InfoCenterNavigationViewModel()
        
        let vc = InfoCenterViewController(viewModel: InfoCenterViewModel(dictNavigator: viewModel))
        
        return InfoCenterNavigationViewController(
            viewModel: viewModel,
            viewController: vc,
            makeDictionaryViewController: {
                return self.makeDictionaryViewController()
            }
        )
    }
    
    func makeSettingsViewController() -> SettingsViewController {
        return SettingsViewController(viewModel: SettingsViewModel())
    }
    
    func makeDictionaryViewController() -> DictionaryViewController {
        return DictionaryViewController(viewModel: DictionaryViewModel())
    }
    
    func makeCalculationNavigationView(type: CalculationType) -> CalculationNavigationViewController {
        let viewModel = CalculationNavigationViewModel()
        var startVC: UIViewController
        
        switch type {
        case .new:
            startVC = makeFromScratchViewController(exitResponder: viewModel,
                                                    optionsResponder: viewModel)
        case .template:
            startVC = makeFromTemplateViewController(exitResponder: viewModel,
                                                     templateResponder: viewModel)
        }
        
        let optionSelectorFactory = {
            return self.makeFromScratchViewController(exitResponder: viewModel,
                                                      optionsResponder: viewModel)
        }
        
        let calcInputFactory: (([Question]) -> UIViewController) = { questions in
            return self.makeCalculatorInputViewController(exitResponder: viewModel, calculationInputResponder: viewModel, questions: questions)
        }
        
        let calcReviewFactory = {
            return self.makeReviewInputViewController(exitResponder: viewModel, reviewResponder: viewModel)
        }
        
        let quickEditReviewFactory: (Question) -> UIViewController = { question in
            return self.makeQuickEditReviewViewController(question: question, editResponder: viewModel)
        }
        
        let detailsViewFactory = {
            return self.makeFinalDetailsViewController()
        }
        
        return CalculationNavigationViewController(viewModel: viewModel,
                                                   viewController: startVC,
                                                   optionSelectorFactory: optionSelectorFactory,
                                                   calculationInputFactory: calcInputFactory,
                                                   calculationReviewFactory: calcReviewFactory,
                                                   quickEditReviewFactory: quickEditReviewFactory,
                                                   detailViewFactory: detailsViewFactory)
    }
    
    func makeFromScratchViewController(exitResponder: ExitFlowResponder, optionsResponder: CalculationOptionsResponder) -> UIViewController {
        return CalculatorOptionsViewController(viewModel: CalculatorOptionsViewModel(exitResponder: exitResponder, optionsResponder: optionsResponder))
    }
    
    func makeFromTemplateViewController(exitResponder: ExitFlowResponder, templateResponder: CalculationTemplateResponder) -> UIViewController {
        return TemplateSelectorViewController(viewModel: TemplateSelectorViewModel(templateRepository: LocalTemplatesRepository(), exitResponder: exitResponder, templateResponder: templateResponder))
    }
    
    func makeCalculatorInputViewController(exitResponder: ExitFlowResponder, calculationInputResponder: CalculationInputResponder, questions: [Question]) -> UIViewController {
        return CalculationInputViewController(viewModel: CalculationInputViewModel(exitResponder: exitResponder, calculationInputResponder: calculationInputResponder, questions: questions))
    }
    
    func makeReviewInputViewController(exitResponder: ExitFlowResponder, reviewResponder: CalculationReviewResponder) -> UIViewController {
        return ReviewInputViewController(viewModel: ReviewInputViewModel(exitResponder: exitResponder, reviewResponder: reviewResponder))
    }
    
    func makeQuickEditReviewViewController(question: Question, editResponder: QuickEditQuestionResponder) -> UIViewController {
        return QuickEditViewController(viewModel: QuickEditViewModel(question: question, editResponder: editResponder))
    }
    
    func makeFinalDetailsViewController() -> UIViewController {
        let vc = FinalDetailsViewController(viewModel: FinalDetailsViewModel())
        return vc
    }
    
    func makeCalculationNavigationViewMOC() -> UIViewController {
        let vc = makeCalculationNavigationView(type: .new)
        let child = makeReviewInputViewController(exitResponder: vc.viewModel, reviewResponder: vc.viewModel)
        vc.viewControllers = [child]
        return vc
    }
}
