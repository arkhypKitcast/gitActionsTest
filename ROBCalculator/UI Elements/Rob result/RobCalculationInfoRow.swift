//
//  RobCalculationInfoRow.swift
//  ROBCalculator
//
//  Created by arkhyp on 24.03.2022.
//

import UIKit

class RobCalculationInfoRow: UIView {
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 8
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.textColor = .textColor2
        view.numberOfLines = 0
        view.font = .appFont(ofSize: 14, weight: .regular)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var valueView: UILabel = {
        let view = UILabel()
        view.textColor = .textColor
        view.font = .appFont(ofSize: 16, weight: .semibold)
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
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
        addSubview(stackView)
        stackView.addArrangedSubview(titleView)
        stackView.addArrangedSubview(valueView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
