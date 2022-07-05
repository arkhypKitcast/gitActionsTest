//
//  EmptyTableView.swift
//  ROBCalculator
//
//  Created by arkhyp on 26.03.2022.
//

import Foundation
import UIKit

class EmptyTableView: UIView {
    lazy var flagView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.image = UIImage(named: "HistoryIcn")?.withTintColor(.appGray3)
        return view
    }()
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.font = .appFont(ofSize: 18, weight: .bold)
        view.text = "History is Empty"
        view.numberOfLines = 0
        view.textColor = .textColor
        view.textAlignment = .center
        return view
    }()
    
    lazy var subtitleView: UILabel = {
        let view = UILabel()
        view.font = .appFont(ofSize: 14, weight: .regular)
        view.text = "You don’t have any calculations"
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
        
    init() {
        super.init(frame: .zero)
        backgroundColor = .appBackground
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
        
        contentStack.setCustomSpacing(24, after: flagView)
        contentStack.setCustomSpacing(4, after: titleView)
        contentStack.setCustomSpacing(24, after: subtitleView)
    
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
