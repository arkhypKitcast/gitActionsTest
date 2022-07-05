//  ReviewQuestionTableViewCell.swift
//  ROBCalculator
//
//  Created by arkhyp on 17.04.2022.
//  
//

import UIKit

struct ReviewQuestionViewData: ViewData {
    var viewType: ConfigurableView.Type = ReviewQuestionTableViewCell.self
    var title: String
    var value: String
}

class ReviewQuestionTableViewCell: ConfigurableTableViewCell {
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground2
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.text = "How much do you pay for a gallon of aviation fuel?"
        view.font = .appFont(ofSize: 17, weight: .regular)
        view.textColor = .appGray
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var valueView: UILabel = {
        let view = UILabel()
        view.text = "0"
        view.font = .appFont(ofSize: 18, weight: .bold)
        view.textColor = .textColor
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        contentView.addSubview(backView)
        backView.addSubview(titleView)
        backView.addSubview(valueView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            backView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            titleView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            titleView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 24),
            titleView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            
            valueView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            valueView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16),
            valueView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            backView.bottomAnchor.constraint(equalTo: valueView.bottomAnchor, constant: 24),
            
        ])
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(ReviewQuestionViewData.self, viewData) else { return }
        titleView.text = model.title
        valueView.text = model.value
    }
}
