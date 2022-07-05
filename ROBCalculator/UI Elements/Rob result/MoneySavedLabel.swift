//
//  MoneySavedLabel.swift
//  ROBCalculator
//
//  Created by arkhyp on 24.03.2022.
//

import UIKit

class MoneySavedLabel: UIView {
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.text = "Money Saved"
        view.textColor = .textColor2
        view.numberOfLines = 0
        view.font = .appFont(ofSize: 14, weight: .regular)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var moneyView: UILabel = {
        let view = UILabel()
        view.text = "$41,13"
        view.textColor = .textColor
        view.numberOfLines = 0
        view.font = .appFont(ofSize: 24, weight: .bold)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .appGreen
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(titleView)
        addSubview(indicatorView)
        addSubview(moneyView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            indicatorView.topAnchor.constraint(equalTo: moneyView.topAnchor, constant: 4),
            indicatorView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: moneyView.centerYAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 6),
//            indicatorView.heightAnchor.constraint(equalToConstant: 24),
            
            moneyView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 4),
            moneyView.leadingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: 8),
            moneyView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            moneyView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
