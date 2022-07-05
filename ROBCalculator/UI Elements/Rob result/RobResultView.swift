//
//  RobResultView.swift
//  ROBCalculator
//
//  Created by arkhyp on 24.03.2022.
//

import Foundation
import UIKit

struct RobResult {
    
}

class RobResultView: UIView {
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 24
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var headerView: RobResultHeaderView = {
        let view = RobResultHeaderView()
        return view
    }()
    
    lazy var dividerView: DividerView = {
        let view = DividerView()
        view.offset = 0
        return view
    }()
    
    lazy var operatingCostView: RobCalculationInfo = {
        let view = RobCalculationInfo()
        view.titleView.text = "Operating"
        return view
    }()
    
    lazy var ownershipCostView: RobCalculationInfo = {
        let view = RobCalculationInfo()
        view.titleView.text = "Ownership"
        return view
    }()
    
    lazy var robCalculationResult: RobCalculationResult = {
        let view = RobCalculationResult()
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .appTutorialButton
        layer.cornerRadius = 22
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(operatingCostView)
        stackView.addArrangedSubview(ownershipCostView)
        stackView.addArrangedSubview(robCalculationResult)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
