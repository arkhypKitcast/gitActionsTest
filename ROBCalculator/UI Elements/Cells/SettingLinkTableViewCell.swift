//  SettingLinkTableViewCell.swift
//  ROBCalculator
//
//  Created by arkhyp on 26.03.2022.
//  
//

import UIKit

struct SettingLinkViewData: ViewData {
    var viewType: ConfigurableView.Type = SettingLinkTableViewCell.self
    let title: String
}

class SettingLinkTableViewCell: ConfigurableTableViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        contentView.backgroundColor = .appBackground2
        tintColor = .appGray2
        
        let heightAnchor = contentView.heightAnchor.constraint(equalToConstant: 48)
        heightAnchor.priority = .defaultHigh
        heightAnchor.isActive = true
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(SettingLinkViewData.self, viewData) else { return }
        var content = defaultContentConfiguration()
        content.text = model.title
        contentConfiguration = content
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}
