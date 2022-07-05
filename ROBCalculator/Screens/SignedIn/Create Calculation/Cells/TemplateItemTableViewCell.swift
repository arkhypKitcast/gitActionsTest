//  TemplateItemTableViewCell.swift
//  ROBCalculator
//
//  Created by arkhyp on 11.04.2022.
//  
//

import UIKit

struct TemplateItemViewData: ViewData {
    var viewType: ConfigurableView.Type = TemplateItemTableViewCell.self
    var image: String?
    var name: String?
    var selectAction: (() -> Void)?
}

class TemplateItemTableViewCell: ConfigurableTableViewCell {
    var selectAction: (() -> Void)?
    
    lazy var planeImageView: ImageView = {
        let view = ImageView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.placeholder = nil//UIImage(named: "piperImage")
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
        view.font = .appFont(ofSize: 18, weight: .bold)
        view.textColor = .textColor
        view.text = "Plane name"
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        var config = UIButton.Configuration.navigation()
        config.title = "Next"
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        config.image = UIImage(named: "Chevron_Right")?.withRenderingMode(.alwaysTemplate)
        view.configuration = config
        view.addAction(UIAction(handler: { [unowned self] _ in
            self.selectAction?()
        }), for: .touchUpInside)
        view.setContentHuggingPriority(.required, for: .horizontal)
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
        contentView.addSubview(planeImageView)
        contentView.addSubview(contentStack)
        
        contentStack.addArrangedSubview(titleView)
        contentStack.addArrangedSubview(nextButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            planeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            planeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            planeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            planeImageView.heightAnchor.constraint(equalToConstant: 185),
            
            contentStack.topAnchor.constraint(equalTo: planeImageView.bottomAnchor, constant: 8),
            contentStack.leadingAnchor.constraint(equalTo: planeImageView.leadingAnchor),
            contentStack.centerXAnchor.constraint(equalTo: planeImageView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 12),
        ])
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(TemplateItemViewData.self, viewData) else { return }
        planeImageView.setupImage(named: model.image ?? "")
        titleView.text = model.name
        selectAction = model.selectAction
    }
}
