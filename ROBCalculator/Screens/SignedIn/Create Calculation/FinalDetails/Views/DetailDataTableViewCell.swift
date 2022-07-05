//  DetailDataTableViewCell.swift
//  ROBCalculator
//
//  Created by arkhyp on 20.04.2022.
//  
//

import UIKit

struct DetailDataViewData: ViewData {
    var viewType: ConfigurableView.Type = DetailDataTableViewCell.self
    var title: String
    var values: [(title: String, value: String)]
}

class DetailDataTableViewCell: ConfigurableTableViewCell {
    
    lazy var dividerView: DividerView = {
        let view = DividerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .appFont(ofSize: 18, weight: .bold)
        view.textColor = .textColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var valueStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(dividerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueStack)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            valueStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            valueStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            valueStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: valueStack.bottomAnchor, constant: 12),
        ])
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(DetailDataViewData.self, viewData) else { return }
        titleLabel.text = model.title
        setupValues(values: model.values)
    }
    
    func setupValues(values: [(title: String, value: String)]) {
        valueStack.removeAllArrangedSubviews()
        values.forEach { value in
            let view = RobCalculationInfoRow()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 38).isActive = true
            view.titleView.text = value.title
            view.valueView.text = value.value
            valueStack.addArrangedSubview(view)
        }
    }
}
