//
//  FromTemplateButton.swift
//  ROBCalculator
//
//  Created by arkhyp on 26.03.2022.
//

import UIKit

class FromTemplateButton: UIButton {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 92).isActive = true
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        var config = UIButton.Configuration.bigPrimary()
        config.title = "Use Template"
        config.image = UIImage(named: "Template")?.withRenderingMode(.alwaysTemplate)
        config.imagePadding = 4
        config.imagePlacement = .top
        config.buttonSize = .medium
        config.cornerStyle = .fixed
        config.background.cornerRadius = 16
        config.background.strokeWidth = 1
        config.background.strokeColor = .borderColor
        config.baseBackgroundColor = .appBackground3
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .appFont(ofSize: 14, weight: .semibold)
            outgoing.foregroundColor = .textColor
            return outgoing
        }
        config.imageColorTransformer =
            UIConfigurationColorTransformer { incoming in
                return UIColor(red: 1, green: 0.731, blue: 0.039, alpha: 1)
        }
        
        configuration = config
    }
}
