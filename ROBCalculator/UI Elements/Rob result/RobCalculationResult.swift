//
//  RobCalculationResult.swift
//  ROBCalculator
//
//  Created by arkhyp on 24.03.2022.
//

import UIKit

class RobCalculationResult: UIView {

    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var moneySavedLabel: MoneySavedLabel = {
        let view = MoneySavedLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var recalculateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var recalculateButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.mediumSeconadry()
        config.title = "Recalculate"
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(stackView)
        
        recalculateView.addSubview(recalculateButton)
        
        stackView.addArrangedSubview(moneySavedLabel)
        stackView.addArrangedSubview(recalculateView)
    }
    
    private func setupConstraints() {
        let topButtonConstraint = recalculateView.heightAnchor.constraint(equalTo: recalculateButton.heightAnchor)
        topButtonConstraint.priority = .defaultLow
        
        recalculateView.setContentHuggingPriority(.required, for: .vertical)
        recalculateView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        recalculateButton.setContentHuggingPriority(.required, for: .vertical)
        recalculateButton.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            topButtonConstraint,
            recalculateButton.topAnchor.constraint(greaterThanOrEqualTo: recalculateView.topAnchor),
            recalculateButton.centerYAnchor.constraint(equalTo: recalculateView.centerYAnchor),
            recalculateButton.trailingAnchor.constraint(equalTo: recalculateView.trailingAnchor),
            recalculateButton.leadingAnchor.constraint(equalTo: recalculateView.leadingAnchor),
            
        ])
    }
}
