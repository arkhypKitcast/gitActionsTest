//  AppLinkTableViewCell.swift
//  ROBCalculator
//
//  Created by arkhyp on 26.03.2022.
//  
//

import UIKit

struct AppLinkViewData: ViewData {
    var viewType: ConfigurableView.Type = AppLinkTableViewCell.self
    var image: String?
    var title: String?
    var subtitle: String?
}

class AppLinkTableViewCell: ConfigurableTableViewCell {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        tintColor = .appGray2
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(AppLinkViewData.self, viewData) else { return }
        var content = defaultContentConfiguration()
        content.imageToTextPadding = 16
        content.text = model.title
        content.secondaryText = model.subtitle
        content.textToSecondaryTextVerticalPadding = 4
        if let imgName = model.image {
            content.image = UIImage(named: imgName)
            content.imageProperties.reservedLayoutSize = CGSize(width: 56, height: 56)
        }
        contentConfiguration = content
    }
}
