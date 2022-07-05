//
//  RobCalculationInfo.swift
//  ROBCalculator
//
//  Created by arkhyp on 24.03.2022.
//

import UIKit

typealias RowInfo = (title: String, value: String)

class RobCalculationInfo: UIView {
    var values: [RowInfo] = []
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.textColor = .textColor
        view.font = .appFont(ofSize: 11, weight: .semibold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 0
        view.axis = .vertical
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
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func setValues(_ values: [RowInfo]) {
        self.values = values
        setup() 
    }
    
    private func setup() {
        stackView.removeAllArrangedSubviews()
        stackView.addArrangedSubview(titleView)
        stackView.setCustomSpacing(8, after: titleView)
        
        setupValues()
    }
    
    private func setupValues() {
        values.forEach { value in
            let view = RobCalculationInfoRow()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 38).isActive = true
            view.titleView.text = value.title
            view.valueView.text = value.value
            stackView.addArrangedSubview(view)
        }
    }
}
