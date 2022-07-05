//  HomeTableViewCell.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//  
//

import UIKit

struct HomeViewData: ViewData {
    var viewType: ConfigurableView.Type = HomeTableViewCell.self
}

class HomeTableViewCell: ConfigurableTableViewCell {
    
    lazy var homeLabel: UILabel = {
        let view = UILabel()
        view.text = "Home"
        view.font = .appFont(ofSize: 32, weight: .bold)
        view.textColor = .appWhite
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var settingsButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.bigPrimary()
        config.image = UIImage(named: "SettingsIcn")?.withRenderingMode(.alwaysTemplate)
        config.baseBackgroundColor = .appBackground2
        config.background.cornerRadius = 22
        config.imageColorTransformer =
            UIConfigurationColorTransformer { incoming in
                return .appBlue
        }
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emptyView: EmptyHomeView = {
        let view = EmptyHomeView()
        return view
    }()
    
    lazy var robResultView: RobResultView = {
        let view = RobResultView()
        view.headerView.titleView.titleView.text = "1974 Piper PA31-350 Navajo Chieftain"
        view.headerView.titleView.subtitleView.text = "N808SM"
        view.headerView.imageView.image = UIImage(named: "piperImage")
        
        view.operatingCostView.setValues([
            RowInfo(title: "Costs Per Hour", value: "$41,13")
        ])
        
        view.ownershipCostView.setValues([
            RowInfo(title: "Total Fixed Costs Per Year", value: "$7145,50"),
            RowInfo(title: "Fixed Cost Per Month", value: "$520,45"),
        ])
    
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(homeLabel)
        contentView.addSubview(settingsButton)
        contentView.addSubview(contentStack)
        
        contentStack.addArrangedSubview(emptyView)
        contentStack.addArrangedSubview(robResultView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            homeLabel.centerYAnchor.constraint(equalTo: settingsButton.centerYAnchor),
            homeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            settingsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            settingsButton.heightAnchor.constraint(equalToConstant: 56),
            settingsButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor),
            
            contentStack.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 24),
            contentStack.leadingAnchor.constraint(equalTo: homeLabel.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: settingsButton.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
        ])
    }
    
    func configure(viewData: ViewData) {
        guard let _ = modelFor(HomeViewData.self, viewData) else { return }
        robResultView.isHidden = true
    }
}
