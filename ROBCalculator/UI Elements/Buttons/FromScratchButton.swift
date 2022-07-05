//
//  FromScratchButton.swift
//  ROBCalculator
//
//  Created by arkhyp on 26.03.2022.
//

import UIKit

class FromScratchButton: UIButton {
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
        config.title = "From Scratch"
        config.image = UIImage(named: "Add_Plus_Circle")?.withRenderingMode(.alwaysTemplate)
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
                return .appBlue
        }
        
        configuration = config
    }
}
