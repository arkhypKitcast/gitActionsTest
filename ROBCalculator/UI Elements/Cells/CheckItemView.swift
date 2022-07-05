//
//  CheckItemView.swift
//  ROBCalculator
//
//  Created by arkhyp on 23.03.2022.
//

import Foundation
import UIKit

class SwitchItemView: ItemView<UISwitch> {
    let switchView = UISwitch()
    init() {
        super.init(switchView)
        switchView.onTintColor = .appBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CheckItemView: ItemView<CheckBox> {
    let checkBox = CheckBox()
    init() {
        super.init(checkBox)
        
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkBox.widthAnchor.constraint(equalToConstant: 24),
            checkBox.heightAnchor.constraint(equalTo: checkBox.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ItemView<ActionView: UIView>: UIView {
    
    let actionView: ActionView
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.textColor = .textColor
        view.font = .appFont(ofSize: 16, weight: .semibold)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(_ actionView: ActionView) {
        self.actionView = actionView
        super.init(frame: .zero)
        clipsToBounds = true
        layer.cornerRadius = 22

        actionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(titleView)
        addSubview(actionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            actionView.leadingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: 8),
            actionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            actionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 72),
        ])
    }
}

class CheckBox: UIControl {
    private let checkedImage = UIImage(named: "Check")?.withRenderingMode(.alwaysTemplate)
    
    var isChecked: Bool {
        didSet {
            updateViewState()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.appGray5.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(_ isChecked: Bool = false) {
        self.isChecked = isChecked
        super.init(frame: .zero)
        
        addSubviews()
        setupConstraints()
        
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateViewState() {
        imageView.layer.borderWidth = isChecked ? 0 : 2
        imageView.image = isChecked ? checkedImage : nil
        imageView.backgroundColor = isChecked ? .appBlue : .appGray6
        imageView.tintColor = .white
    }
    
    private func addSubviews() {
        addSubview(imageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    
    @objc func buttonClicked() {
        isChecked = !isChecked
        sendActions(for: .valueChanged)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
       let biggerFrame = bounds.insetBy(dx: -30, dy: -30)
       return biggerFrame.contains(point)
    }
}
