//
//  DividerView.swift
//  ROBCalculator
//
//  Created by arkhyp on 24.03.2022.
//

import Foundation
import UIKit

class DividerView: UIView {
    private var leadingConstraint: NSLayoutConstraint!
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var offset: CGFloat = 16 {
        didSet {
            leadingConstraint.constant = offset
        }
    }
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(dividerView)
    }
    
    private func setupConstraints() {
        leadingConstraint = dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset)
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            leadingConstraint,
            dividerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dividerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
