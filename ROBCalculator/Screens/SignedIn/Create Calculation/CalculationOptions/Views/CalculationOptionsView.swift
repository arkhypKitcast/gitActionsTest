//
//  CalculationOptionsView.swift
//  ROBCalculator
//
//  Created by arkhyp on 13.04.2022.
//

import UIKit

class CalculationOptionsView: UIView {
    
    var didSelectOperating: ((Bool) -> Void)?
    var didSelectOwnership: ((Bool) -> Void)?
    var didSelectOwnershipFinancing: ((Bool) -> Void)?
    
    var isOperating: Bool = false {
        didSet {
            didSelectOperating?(isOperating)
            updateUI()
        }
    }
    
    var isOwnership: Bool = false {
        didSet {
            didSelectOwnership?(isOwnership)
            updateUI()
        }
    }
    
    var isOwnershipFinancing: Bool = false {
        didSet {
            didSelectOwnershipFinancing?(isOwnershipFinancing)
            updateUI()
        }
    }
    
    lazy var operatingCostView: CheckItemView = {
        let view = CheckItemView()
        view.actionView.isChecked = false
        view.backgroundColor = .appTutorialButton
        view.titleView.text = "Operating Cost"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ownershipCostContent: UIView = {
        let view = UIView()
        view.backgroundColor = .appTutorialButton
        view.clipsToBounds = true
        view.layer.cornerRadius = 22
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ownershipCostStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ownershipCostView: CheckItemView = {
        let view = CheckItemView()
        view.actionView.isChecked = false
        view.titleView.text = "Ownership Cost"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var financingView: SwitchItemView = {
        let view = SwitchItemView()
        view.actionView.isOn = false
        view.titleView.text = "Financing"
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dividerView: DividerView = {
        let view = DividerView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        subscribe()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(operatingCostView)
        addSubview(ownershipCostContent)
        
        ownershipCostContent.addSubview(ownershipCostStack)
        
        ownershipCostStack.addArrangedSubview(ownershipCostView)
        ownershipCostStack.addArrangedSubview(dividerView)
        ownershipCostStack.addArrangedSubview(financingView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            operatingCostView.topAnchor.constraint(equalTo: topAnchor),
            operatingCostView.leadingAnchor.constraint(equalTo: leadingAnchor),
            operatingCostView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            ownershipCostContent.topAnchor.constraint(equalTo: operatingCostView.bottomAnchor, constant: 16),
            ownershipCostContent.leadingAnchor.constraint(equalTo: leadingAnchor),
            ownershipCostContent.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: ownershipCostContent.bottomAnchor),
            
            ownershipCostStack.topAnchor.constraint(equalTo: ownershipCostContent.topAnchor),
            ownershipCostStack.leadingAnchor.constraint(equalTo: ownershipCostContent.leadingAnchor),
            ownershipCostStack.trailingAnchor.constraint(equalTo: ownershipCostContent.trailingAnchor),
            ownershipCostStack.bottomAnchor.constraint(equalTo: ownershipCostContent.bottomAnchor),
        ])
    }
    
    func subscribe() {
        let operTap = UITapGestureRecognizer(target: self, action: #selector(operatingGesture))
        operatingCostView.addGestureRecognizer(operTap)
        
        let ownerTap = UITapGestureRecognizer(target: self, action: #selector(ownershipGesture))
        ownershipCostView.addGestureRecognizer(ownerTap)
        
        financingView.switchView.addTarget(self, action: #selector(ownershipFinancingChanged), for: .valueChanged)
    }
    
    @objc
    func operatingGesture() {
        isOperating = !isOperating
        operatingCostView.checkBox.isChecked = isOperating
    }
    
    @objc
    func ownershipGesture() {
        isOwnership = !isOwnership
        ownershipCostView.checkBox.isChecked = isOwnership
    }
    
    @objc
    func ownershipFinancingChanged() {
        isOwnershipFinancing = financingView.switchView.isOn
    }
    
    func updateUI() {
//        self.dividerView.layer.removeAllAnimations()
//        self.financingView.layer.removeAllAnimations()
        
        self.dividerView.isHidden = !self.isOwnership
        self.financingView.isHidden = !self.isOwnership
        
        self.dividerView.alpha = self.isOwnership ? 1 : 0
        self.financingView.alpha = self.isOwnership ? 1 : 0
//
//        UIView.animate(withDuration: 0.3) {
//            self.dividerView.isHidden = !self.isOwnership
//            self.financingView.isHidden = !self.isOwnership
//
//            self.dividerView.alpha = self.isOwnership ? 1 : 0
//            self.financingView.alpha = self.isOwnership ? 1 : 0
//        }
    }
}
