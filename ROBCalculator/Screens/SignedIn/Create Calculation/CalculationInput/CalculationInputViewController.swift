//
//  CalculationInputViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 13.04.2022.
//

import Foundation
import UIKit
import Combine
import SwiftUI

class CalculationInputViewController: NiblessViewController {
    let viewModel: CalculationInputViewModel
    var cancellables = Set<AnyCancellable>()
    var questionView: UIView?
    
    lazy var endEditingGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        return gesture
    }()
    
    lazy var closeButton: UIBarButtonItem = {
        let image = UIImage(named: "CloseMD")?.withRenderingMode(.alwaysTemplate)
        let view = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        view.target = viewModel
        view.action = #selector(CalculatorOptionsViewModel.closeFlow)
        view.tintColor = .appGray
        view.customView?.layer.cornerRadius = 24
        return view
    }()
    
    lazy var progressView: ProgressView = {
        let view = ProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var prevButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.bigSeconadry()
        config.image = UIImage(named: "Chevron_Left")?.withRenderingMode(.alwaysTemplate)
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.bigPrimary(view)
        config.title = "Next"
        config.image = UIImage(named: "Chevron_Right")?.withRenderingMode(.alwaysTemplate)
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var completionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .appGray
        view.font = .appFont(ofSize: 12, weight: .semibold)
        view.text = "Question 1 of 8"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var questionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .textColor
        view.font = .appFont(ofSize: 24, weight: .bold)
        view.text = "How much do you pay for a gallon of aviation fuel?"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var questionValueView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .appGray
        view.font = .appFont(ofSize: 12, weight: .regular)
        view.text = "Hint: Input Hours to TBO"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: CalculationInputViewModel) {
        self.viewModel = viewModel
        super.init()
        view.backgroundColor = .appBackground
        addKeyboardObservers()
        addSubviews()
        setupConstraints()
        subscribe()
        view.addGestureRecognizer(endEditingGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addSubviews() {
        view.addSubview(prevButton)
        view.addSubview(nextButton)
        view.addSubview(progressView)
        view.addSubview(completionLabel)
        view.addSubview(questionLabel)
        view.addSubview(questionValueView)
        view.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            prevButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            nextButton.centerYAnchor.constraint(equalTo: prevButton.centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            progressView.topAnchor.constraint(equalTo: prevButton.bottomAnchor, constant: 24),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 4),
            
            completionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            completionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            completionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: completionLabel.bottomAnchor, constant: 8),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            questionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            questionValueView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 24),
            questionValueView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            questionValueView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: questionValueView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    func subscribe() {
        viewModel.$progress
            .sink {[weak self] progress in
                self?.progressView.progress = CGFloat(progress)
            }
            .store(in: &cancellables)
        
        viewModel.$backIsHidden.assign(to: \.isHidden, on: prevButton).store(in: &cancellables)
        viewModel.$nextIsHidden.assign(to: \.isHidden, on: nextButton).store(in: &cancellables)
        viewModel.$nextIsEnabled.assign(to: \.isEnabled, on: nextButton).store(in: &cancellables)
        
        viewModel.$completionText.assign(to: \.text, on: completionLabel).store(in: &cancellables)
        viewModel.$progress.map({ CGFloat($0) }).assign(to: \.progress, on: progressView).store(in: &cancellables)
        viewModel.$currentQuestion.sink { [weak self] question in
            self?.descriptionLabel.text = question?.qDescription
            self?.questionLabel.text = question?.title
            self?.setupView(for: question as? QuestionViewery)
        }.store(in: &cancellables)
        
        prevButton.addTarget(viewModel, action: #selector(CalculationInputViewModel.goPrevious), for: .touchUpInside)
        nextButton.addTarget(viewModel, action: #selector(CalculationInputViewModel.goNext), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.rightBarButtonItem = closeButton
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func setupView(for question: QuestionViewery?) {
        guard let question = question else {
            return
        }
        
        removeCurrentQuestionView()
        let questionView = question.view()
        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionValueView.addSubview(questionView)
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: questionValueView.topAnchor, constant: 24),
            questionView.leadingAnchor.constraint(equalTo: questionValueView.leadingAnchor, constant: 12),
            questionView.centerXAnchor.constraint(equalTo: questionValueView.centerXAnchor),
            questionView.centerYAnchor.constraint(equalTo: questionValueView.centerYAnchor),
            
//            questionView.heightAnchor.constraint(equalToConstant: 100)
        ])
            
        self.questionView = questionView
        questionView.becomeFirstResponder()
//        if self.questionView == nil {
//            self.questionView = questionView
//        } else {
//            animate(outView: self.questionView, inView: questionView) {
//                self.questionView = questionView
//            }
//        }
    }
    
    func animate(outView: UIView?, inView: UIView, completion: @escaping (() -> Void)) {
        inView.transform = CGAffineTransform(translationX: questionValueView.frame.maxX, y: 0)
        UIView.animate(withDuration: 0.6) {
            outView?.transform = CGAffineTransform(translationX: -(outView?.frame.maxX ?? 0), y: 0)
            inView.transform = .identity
        } completion: { _ in
            completion()
        }
    }

    func removeCurrentQuestionView() {
        questionView?.removeFromSuperview()
    }
    
    @objc
    func endEditing() {
        view.endEditing(true)
    }
}

