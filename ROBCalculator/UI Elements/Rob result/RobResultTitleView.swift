//
//  RobResultTitleView.swift
//  ROBCalculator
//
//  Created by arkhyp on 24.03.2022.
//

import UIKit

class RobResultTitleView: UIView {
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.textColor = .textColor
        view.numberOfLines = 0
        view.font = .appFont(ofSize: 18, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var subtitleView: UILabel = {
        let view = UILabel()
        view.textColor = .textColor2
        view.font = .appFont(ofSize: 14, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var detailButton: UIButton = {
        let view = UIButton(type: .system)
        var config = UIButton.Configuration.navigation()
        config.title = "Detail"
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 0)
        config.image = UIImage(named: "Chevron_Right")?.withRenderingMode(.alwaysTemplate)
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleStack: UIStackView = {
        let view = UIStackView()
        view.spacing = 8
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
        addSubview(titleStack)
        addSubview(detailButton)
        
        titleStack.addArrangedSubview(titleView)
        titleStack.addArrangedSubview(subtitleView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: topAnchor),
            titleStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            detailButton.topAnchor.constraint(equalTo: topAnchor),
            detailButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleStack.trailingAnchor, constant: 16),
            detailButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}
