//
//  EmptyHomeView.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import Foundation
import UIKit

class EmptyHomeView: UIView {
    lazy var flagView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.image = UIImage(named: "Flag")?.withTintColor(.appGray3)
        
        return view
    }()
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.font = .appFont(ofSize: 18, weight: .bold)
        view.text = "Let’s make your first calculation!"
        view.numberOfLines = 0
        view.textColor = .textColor
        view.textAlignment = .center
        return view
    }()
    
    lazy var subtitleView: UILabel = {
        let view = UILabel()
        view.font = .appFont(ofSize: 14, weight: .regular)
        view.text = "Select one option to continue"
        view.numberOfLines = 0
        view.textColor = .appGray
        view.textAlignment = .center
        return view
    }()
    
    lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buttonStack: UIStackView = {
        let view = UIStackView()
        view.spacing = 16
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var templateButton: FromTemplateButton = {
        let view = FromTemplateButton()
        return view
    }()
    
    lazy var scratchButton: FromScratchButton = {
        let view = FromScratchButton()
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .appBackground2
        layer.cornerRadius = 22
        layer.shadowColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.07).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 16
        layer.shadowOffset = CGSize(width: 0, height: 4)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(contentStack)
        
        contentStack.addArrangedSubview(flagView)
        contentStack.addArrangedSubview(titleView)
        contentStack.addArrangedSubview(subtitleView)
        contentStack.addArrangedSubview(buttonStack)

        buttonStack.addArrangedSubview(templateButton)
        buttonStack.addArrangedSubview(scratchButton)
        
        contentStack.setCustomSpacing(24, after: flagView)
        contentStack.setCustomSpacing(4, after: titleView)
        contentStack.setCustomSpacing(24, after: subtitleView)
    
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
