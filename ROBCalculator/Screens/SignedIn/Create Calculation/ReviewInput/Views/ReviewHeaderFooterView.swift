//  ReviewHeaderFooterView.swift
//  ROBCalculator
//
//  Created by arkhyp on 16.04.2022.
//  
//

import UIKit

struct ReviewViewData: ViewData {
    var viewType: ConfigurableView.Type = ReviewHeaderFooterView.self
    var title: String
    var hide: Bool
    var hideToggleAction: (() -> Void)?
}

class ReviewHeaderFooterView: ConfigurableTableViewHeaderFooterView {
    var hide: Bool = false
    var hideToggleAction: (() -> Void)?
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.text = "Operating Cost"
        view.font = .appFont(ofSize: 24, weight: .bold)
        view.textColor = .textColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var hideButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(performAction), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        var bgConfig = UIBackgroundConfiguration.listPlainCell()
        bgConfig.backgroundColor = UIColor.clear
        backgroundConfiguration = bgConfig
        contentView.backgroundColor = .appBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(titleView)
        contentView.addSubview(hideButton)
    }
    
    private func addConstraints() {
        let constraints = [
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            hideButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleView.trailingAnchor, constant: 8),
            hideButton.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            contentView.trailingAnchor.constraint(equalTo: hideButton.trailingAnchor, constant: 16),
            hideButton.widthAnchor.constraint(equalToConstant: 96),
            hideButton.heightAnchor.constraint(equalToConstant: 36),
        ]
        constraints.forEach({ $0.priority = .defaultHigh })
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(ReviewViewData.self, viewData) else { return }
        titleView.text = model.title
        hide = model.hide
        hideToggleAction = model.hideToggleAction
        updateButton()
    }
    
    func updateButton() {
        var config = UIButton.Configuration.mediumSeconadry()
        
        let imgName = !hide ? "Hide" : "Show"
        config.title = !hide ? "Hide" : "Show"
        config.image = UIImage(named: imgName)?.withRenderingMode(.alwaysTemplate)
        config.imageColorTransformer = UIConfigurationColorTransformer({ _ in
            return .appBlue
        })
        config.cornerStyle = .capsule
        hideButton.configuration = config
    }
    
    @objc
    func performAction() {
        hide = !hide
        updateButton()
        hideToggleAction?()
    }
}
