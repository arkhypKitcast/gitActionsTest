//
//  QuickEditViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 17.04.2022.
//

import UIKit

class QuickEditViewController: NiblessViewController {
    let viewModel: QuickEditViewModel
    var questionView: UIView?
    
    lazy var endEditingGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        return gesture
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pinView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 4),
            view.widthAnchor.constraint(equalToConstant: 48)
        ])
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
        view.backgroundColor = .appBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dividerView: DividerView = {
        let view = DividerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buttonStack: UIStackView = {
        let view = UIStackView()
        view.spacing = 8
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var saveButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.bigPrimary(view)
        config.title = "Confirm"
        config.imagePlacement = .leading
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addAction(UIAction(handler: { [unowned self] _ in
            self.viewModel.approveQuestion()
        }), for: .touchUpInside)
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.bigSeconadry()
        config.title = "Cancel"
        config.imagePlacement = .leading
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addAction(UIAction(handler: { [unowned self] _ in
            self.dismiss(animated: true)
        }), for: .touchUpInside)
        return view
    }()
    
    init(viewModel: QuickEditViewModel) {
        self.viewModel = viewModel
        super.init()
        
        addSubviews()
        setupConstraint()
        addKeyboardObservers()
        
        view.addGestureRecognizer(endEditingGesture)
        
        setupView(for: viewModel.question as? QuestionViewery)
        
        view.backgroundColor = .clear
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.roundCorners(corners: [.topLeft, .topRight], radius: 22)
    }
    
    func addSubviews() {
        view.addSubview(contentView)
        
        contentView.addSubview(pinView)
        contentView.addSubview(questionLabel)
        contentView.addSubview(questionValueView)
        contentView.addSubview(dividerView)
        contentView.addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(saveButton)
        buttonStack.addArrangedSubview(cancelButton)
    }
    
    func setupConstraint() {
        let bottomConstraint = view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 8)
        bottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pinView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            pinView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 44),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            questionValueView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 24),
            questionValueView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            questionValueView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            dividerView.topAnchor.constraint(equalTo: questionValueView.bottomAnchor, constant: 1),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            buttonStack.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 24),
            buttonStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            bottomConstraint,
        ])
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
            questionView.topAnchor.constraint(equalTo: questionValueView.topAnchor, constant: 8),
            questionView.leadingAnchor.constraint(equalTo: questionValueView.leadingAnchor, constant: 16),
            questionView.centerXAnchor.constraint(equalTo: questionValueView.centerXAnchor),
            questionView.centerYAnchor.constraint(equalTo: questionValueView.centerYAnchor),
        ])
            
        self.questionView = questionView
        questionView.becomeFirstResponder()
    }

    func removeCurrentQuestionView() {
        questionView?.removeFromSuperview()
    }
    
    @objc
    func endEditing() {
        view.endEditing(true)
    }
}
