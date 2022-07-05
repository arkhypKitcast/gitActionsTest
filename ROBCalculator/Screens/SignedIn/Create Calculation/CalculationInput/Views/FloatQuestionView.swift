//
//  FloatQuestionView.swift
//  ROBCalculator
//
//  Created by arkhyp on 15.04.2022.
//

import UIKit

extension DoubleQuestion: QuestionViewery {
    func view() -> UIView {
        let view = FloatQuestionView(question: self)
        return view
    }
}

class FloatQuestionView: UIView {
    var txLeadingConstraint: NSLayoutConstraint!
    var offsetLeadingConstraint: NSLayoutConstraint!
    
    let question: DoubleQuestion
    lazy var valueTextField: UITextField = {
        let view = UITextField()
        view.keyboardType = .decimalPad
        view.tintColor = .appBlue
        view.textColor = .textColor
        view.font = .appFont(ofSize: 32, weight: .bold)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var measureLabel: UILabel = {
        let view = UILabel()
        view.textColor = .appGray
        view.font = .appFont(ofSize: 18, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var becomeFirstResponderGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(startEditing))
        return gesture
    }()
    
    required init(question: DoubleQuestion) {
        self.question = question
        super.init(frame: .zero)
        addSubviews()
        addConstraints()
        
        addGestureRecognizer(becomeFirstResponderGesture)
        
        valueTextField.attributedPlaceholder = NSAttributedString(string: question.placeholder ?? " ", attributes: [.foregroundColor : UIColor.appGray, .font : UIFont.appFont(ofSize: 32, weight: .bold)])
        valueTextField.addAction(UIAction(handler: { [unowned self] _ in
            self.didChangeTextFieldValue()
        }), for: .editingChanged)
        measureLabel.text = question.measure
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(valueTextField)
        addSubview(measureLabel)
    }
    
    private func addConstraints() {
        txLeadingConstraint = measureLabel.leadingAnchor.constraint(equalTo: valueTextField.trailingAnchor, constant: 6)
        offsetLeadingConstraint = measureLabel.leadingAnchor.constraint(equalTo: valueTextField.leadingAnchor, constant: 6)
        
        NSLayoutConstraint.activate([
            valueTextField.topAnchor.constraint(equalTo: topAnchor),
            valueTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            txLeadingConstraint,
            measureLabel.lastBaselineAnchor.constraint(equalTo: valueTextField.lastBaselineAnchor),
            trailingAnchor.constraint(greaterThanOrEqualTo: measureLabel.trailingAnchor),
        ])
    }
    
    override func becomeFirstResponder() -> Bool {
        return valueTextField.becomeFirstResponder()
    }
    
    @objc
    func startEditing() {
        _ = becomeFirstResponder()
    }
    
    @objc
    func didChangeTextFieldValue() {
        if valueTextField.isFirstResponder {
            
        } else {
            
        }
    }
}

extension FloatQuestionView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText: NSString = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string).replacingOccurrences(of: ",", with: ".")
        
        let double = Double(updatedText)
        
        let items = updatedText.components(separatedBy: CharacterSet(charactersIn: ".,"))
        
        if let fItem = items.first, fItem.count >= 10 {
            return false
        }
        
        if items.count == 2, items[1].count > 2 {
            return false
        }
        
        question.value = double

        return double != nil || updatedText.isEmpty
    }
}
