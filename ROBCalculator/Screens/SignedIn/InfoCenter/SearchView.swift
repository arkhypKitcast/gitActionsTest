//
//  SearchView.swift
//  ROBCalculator
//
//  Created by arkhyp on 10.04.2022.
//

import UIKit

class SearchView: UIView {
    lazy var searchField: UISearchTextField = {
        let view = UISearchTextField()
        view.placeholder = "Search"
        view.tintColor = .appBlue
        view.textColor = .textColor
        view.backgroundColor = .appGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(searchField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchField.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchField.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
