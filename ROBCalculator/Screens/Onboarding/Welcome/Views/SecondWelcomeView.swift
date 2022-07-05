//
//  SecondWelcomeView.swift
//  ROBCalculator
//
//  Created by arkhyp on 23.03.2022.
//

import Foundation
import UIKit

class SecondWelcomeView: UIView, WelcomeStepView {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .textColor
        view.text = "Select what you need\nto calculate from scratch"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = .appFont(ofSize: 24, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var operatingCostView: CheckItemView = {
        let view = CheckItemView()
        view.actionView.isChecked = false
        view.backgroundColor = .appTutorialButton
        view.titleView.text = "Operating Cost"
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ownershipCostContent: UIView = {
        let view = UIView()
        view.backgroundColor = .appTutorialButton
        view.clipsToBounds = true
        view.layer.cornerRadius = 22
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ownershipCostView: CheckItemView = {
        let view = CheckItemView()
        view.actionView.isChecked = true
        view.titleView.text = "Ownership Cost"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var financingView: SwitchItemView = {
        let view = SwitchItemView()
        view.actionView.isOn = false
        view.titleView.text = "Financing"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIImageView()
        view.image = UIImage(named: "Line2")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        prepareForAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(lineView)
        addSubview(titleLabel)
        addSubview(operatingCostView)
        addSubview(ownershipCostContent)
        
        ownershipCostContent.addSubview(ownershipCostView)
        ownershipCostContent.addSubview(dividerView)
        ownershipCostContent.addSubview(financingView)
    }
    
    func setupConstraints() {
        let operatingCostViewWidth = operatingCostView.widthAnchor.constraint(equalToConstant: 350)
        operatingCostViewWidth.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: operatingCostView.centerXAnchor, constant: -100),
            lineView.bottomAnchor.constraint(equalTo: ownershipCostContent.bottomAnchor, constant: 80),
            //
            ownershipCostContent.topAnchor.constraint(equalTo: centerYAnchor, constant: -16),
            operatingCostView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            operatingCostView.centerXAnchor.constraint(equalTo: centerXAnchor),
            operatingCostViewWidth,
            
            ownershipCostContent.topAnchor.constraint(equalTo: operatingCostView.bottomAnchor, constant: 16),
            ownershipCostContent.leadingAnchor.constraint(equalTo: operatingCostView.leadingAnchor),
            ownershipCostContent.centerXAnchor.constraint(equalTo: operatingCostView.centerXAnchor),
            
            ownershipCostView.topAnchor.constraint(equalTo: ownershipCostContent.topAnchor),
            ownershipCostView.leadingAnchor.constraint(equalTo: ownershipCostContent.leadingAnchor),
            ownershipCostView.trailingAnchor.constraint(equalTo: ownershipCostContent.trailingAnchor),
            
            dividerView.topAnchor.constraint(equalTo: ownershipCostView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: ownershipCostView.leadingAnchor, constant: 16),
            dividerView.centerXAnchor.constraint(equalTo: ownershipCostView.centerXAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            financingView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
            financingView.leadingAnchor.constraint(equalTo: ownershipCostView.leadingAnchor),
            financingView.centerXAnchor.constraint(equalTo: ownershipCostView.centerXAnchor),
            financingView.bottomAnchor.constraint(equalTo: ownershipCostContent.bottomAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func prepareForAnimation() {
        self.operatingCostView.alpha = 0
        self.operatingCostView.transform = .init(translationX: 0, y: -200)
        
        self.ownershipCostContent.alpha = 0
        self.ownershipCostContent.transform = .init(translationX: 0, y: -200)
        
        self.lineView.alpha = 0
    }
    
    func startAnimation(completion: @escaping () -> ()) {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.allowUserInteraction]) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.ownershipCostContent.alpha = 1
                self.ownershipCostContent.transform = .identity
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.operatingCostView.alpha = 1
                self.operatingCostView.transform = .identity
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.lineView.alpha = 1
            }
        } completion: { _ in
            completion()
        }
    }
}
