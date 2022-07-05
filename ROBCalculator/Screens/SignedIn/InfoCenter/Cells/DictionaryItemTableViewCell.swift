//  DictionaryItemTableViewCell.swift
//  ROBCalculator
//
//  Created by arkhyp on 10.04.2022.
//  
//

import UIKit

struct DictionaryItemViewData: ViewData {
    var viewType: ConfigurableView.Type = DictionaryItemTableViewCell.self
    var title: String
    var text: String
    var expanded: Bool?
    var indexPath: IndexPath?
    var didExpandAction: ((IndexPath, Bool) -> Void)?
}

class DictionaryItemTableViewCell: ConfigurableTableViewCell {
    var model: DictionaryItemViewData!
    var didExpandAction: ((IndexPath, Bool) -> Void)?
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBackground2
        view.layer.cornerRadius = 22
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.spacing = 8
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleContentStack: UIStackView = {
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
    
    lazy var expandButton: UIButton = {
        let view = UIButton(type: .system)
        var config = UIButton.Configuration.navigation()
        config.image = UIImage(named: "Add_Plus")?.withRenderingMode(.alwaysTemplate)
        view.configuration = config
        view.addAction(UIAction(handler: { [unowned self] _ in
            guard let indexPath = self.model.indexPath else { return }
            let newValue = !(self.model.expanded ?? false)
            self.model.expanded = newValue
            self.setupExpand(newValue)
            self.didExpandAction?(indexPath, newValue)
        }), for: .touchUpInside)
        return view
    }()
    
    lazy var textView: UILabel = {
        let view = UILabel()
        view.font = .appFont(ofSize: 17, weight: .regular)
        view.textColor = .appGray
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
        contentView.addSubview(backView)
        backView.addSubview(contentStack)
        backView.addSubview(textView)
        
        contentStack.addArrangedSubview(titleContentStack)
        
        titleContentStack.addArrangedSubview(titleView)
        titleContentStack.addArrangedSubview(expandButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            contentStack.topAnchor.constraint(equalTo: backView.topAnchor, constant: 24),
            contentStack.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            contentStack.heightAnchor.constraint(equalToConstant: 24),
            
            textView.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            backView.bottomAnchor.constraint(greaterThanOrEqualTo: textView.bottomAnchor, constant: 24)
        ])
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(DictionaryItemViewData.self, viewData) else { return }
        self.model = model
        titleView.text = model.title
        textView.text = model.text
        setupExpand(model.expanded ?? false)
        didExpandAction = model.didExpandAction
        
        expandButton.isHidden = model.expanded == nil
        if expandButton.isHidden {
            textView.numberOfLines = 0
        }
        
    }
    
    func setupExpand(_ isExpanded: Bool) {
        let numberOfLines = isExpanded ? 0 : 2
        let imgName = isExpanded ? "Remove_Minus" : "Add_Plus"
        let image = UIImage(named: imgName)?.withRenderingMode(.alwaysTemplate)
        expandButton.configuration?.image = image
        textView.numberOfLines = numberOfLines
    }
}
