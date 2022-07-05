//  DictionaryHeaderFooterView.swift
//  ROBCalculator
//
//  Created by arkhyp on 10.04.2022.
//  
//

import UIKit

struct DictionaryViewData: ViewData {
    var viewType: ConfigurableView.Type = DictionaryHeaderFooterView.self
    var seeDictionaryAction: (() -> Void)?
}

class DictionaryHeaderFooterView: ConfigurableTableViewHeaderFooterView {
    var seeDictionaryAction: (() -> Void)?
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.font = .appFont(ofSize: 24, weight: .bold)
        view.textColor = .textColor
        view.text = "Dictionary"
        return view
    }()
    
    lazy var seeAllButton: UIButton = {
        let view = UIButton(type: .system)
        var config = UIButton.Configuration.navigation()
        config.title = "See all"
        config.image = UIImage(named: "Chevron_Right")?.withRenderingMode(.alwaysTemplate)
        view.configuration = config
        view.addAction(UIAction(handler: { [unowned self] _ in
            self.seeDictionaryAction?()
        }), for: .touchUpInside)
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(lineView)
        contentView.addSubview(contentStack)
        
        contentStack.addArrangedSubview(titleView)
        contentStack.addArrangedSubview(seeAllButton)
    }
    
    private func addConstraints() {
        let constr = [
            lineView.topAnchor.constraint(equalTo: contentView.topAnchor),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lineView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            contentStack.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            contentStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 8),
        ]
        constr.forEach({ $0.priority = .init(rawValue: 999) })
        NSLayoutConstraint.activate(constr)
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(DictionaryViewData.self, viewData) else { return }
        self.seeDictionaryAction = model.seeDictionaryAction
    }
}
