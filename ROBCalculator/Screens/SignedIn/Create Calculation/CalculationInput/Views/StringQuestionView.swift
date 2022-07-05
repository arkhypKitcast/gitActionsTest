//
//  StringQuestionView.swift
//  ROBCalculator
//
//  Created by arkhyp on 15.04.2022.
//

import UIKit

protocol QuestionViewery {
    func view() -> UIView
}

extension StringQuestion: QuestionViewery {
    func view() -> UIView {
        let view = StringQuestionView(question: self)
        return view
    }
}

class StringQuestionView: UIView {
    
    let question: StringQuestion
    
    lazy var placeholerView: UITextView = {
        let view = UITextView()
        view.textColor = .appGray
        view.backgroundColor = .clear
        view.font = .appFont(ofSize: 32, weight: .bold)
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.tintColor = .appBlue
        view.backgroundColor = .clear
        view.textColor = .textColor
        view.font = .appFont(ofSize: 32, weight: .bold)
        view.delegate = self
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init(question: StringQuestion) {
        self.question = question
        super.init(frame: .zero)
        addSubviews()
        addConstraints()
        
        placeholerView.text = question.placeholder
        textView.text = question.value
        
        placeholerView.isHidden = !(question.value?.isEmpty ?? true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(placeholerView)
        addSubview(textView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textView.heightAnchor.constraint(lessThanOrEqualToConstant: 160),
            
            placeholerView.topAnchor.constraint(equalTo: topAnchor),
            placeholerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            placeholerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            placeholerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func becomeFirstResponder() -> Bool {
        return textView.becomeFirstResponder()
    }
}

extension StringQuestionView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText: NSString = textView.text as NSString
        let updatedText = currentText.replacingCharacters(in: range, with:text)
        
        placeholerView.isHidden = !updatedText.isEmpty
        
        let txt = UITextView()
        txt.font = textView.font
        txt.frame = textView.bounds
        txt.text = updatedText
        let size = txt.sizeThatFits(CGSize(width: textView.bounds.width, height: textView.bounds.height))
        
        question.value = updatedText
        
        return (!updatedText.isContainsNewlines) && size.height <= 160
    }
}

extension String{
    var isContainsNewlines : Bool {
        let letters = CharacterSet.newlines
        return self.rangeOfCharacter(from: letters) != nil
    }
}
