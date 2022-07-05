//
//  Configurations.swift
//  ROBCalculator
//
//  Created by arkhyp on 22.03.2022.
//

import Foundation
import UIKit

//MARK: - Primary Configuration
extension UIButton.Configuration {
    static func bigPrimary(_ button: UIButton? = nil) -> UIButton.Configuration {
        var config = UIButton.Configuration.primary(button)
        config.buttonSize = .large
        config.cornerStyle = .dynamic
        config.background.cornerRadius = 22
        return config
    }
    
    static func mediumPrimary(_ button: UIButton? = nil) -> UIButton.Configuration {
        var config = UIButton.Configuration.primary(button)
        config.buttonSize = .medium
        return config
    }
    
    static func primary(_ button: UIButton? = nil) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
//        config.background.backgroundColorTransformer = UIConfigurationColorTransformer { incoming in
//            if let button = button {
//                switch button.state {
//                case .disabled:
//                    return (config.baseBackgroundColor ?? incoming).withAlphaComponent(0.5)
//                default:
//                    return incoming
//                }
//            }
//            return incoming
//        }
        config.baseBackgroundColor = .appBlue
        config.cornerStyle = .large
        
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
              var outgoing = incoming
              outgoing.font = .appFont(ofSize: 17, weight: .semibold)
              outgoing.foregroundColor = .appWhite
              if let button = button {
                  switch button.state {
                  case .disabled:
                      outgoing.foregroundColor = .appWhite.withAlphaComponent(0.5)
                  default:
                      outgoing.foregroundColor = .appWhite
                  }
              }
              return outgoing
          }
        
        config.imagePadding = 8
        config.imagePlacement = .trailing
        config.imageColorTransformer =
            UIConfigurationColorTransformer { incoming in
                if let button = button {
                    switch button.state {
                    case .disabled:
                        return .appWhite.withAlphaComponent(0.5)
                    default:
                        return .appWhite
                    }
                }
                return .appWhite
        }
        return config
    }
}

//MARK: - Secondary Configuration
extension UIButton.Configuration {
    static func bigSeconadry() -> UIButton.Configuration {
        var config = UIButton.Configuration.seconadry()
        config.buttonSize = .large
        config.cornerStyle = .dynamic
        config.background.cornerRadius = 22
        return config
    }
    
    static func mediumSeconadry() -> UIButton.Configuration {
        var config = UIButton.Configuration.seconadry()
        config.buttonSize = .medium
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
              var outgoing = incoming
              outgoing.font = .appFont(ofSize: 14, weight: .semibold)
              outgoing.foregroundColor = .appBlue
              return outgoing
          }
        return config
    }
    
    static func seconadry() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        
        config.baseBackgroundColor = .appSecondaryButton
        config.cornerStyle = .large
        
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
              var outgoing = incoming
              outgoing.font = .appFont(ofSize: 17, weight: .semibold)
              outgoing.foregroundColor = .appBlue
              return outgoing
          }
        
        config.imagePadding = 8
        config.imagePlacement = .trailing
        config.imageColorTransformer =
            UIConfigurationColorTransformer { incoming in
                return .appBlue
        }
        return config
    }
}

//MARK: - Outline Configuration

//MARK: - Navigation Configuration
extension UIButton.Configuration {
    static func navigation() -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        
//        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 0)
        
        config.titleTextAttributesTransformer =
          UIConfigurationTextAttributesTransformer { incoming in
              var outgoing = incoming
              outgoing.font = .appFont(ofSize: 14, weight: .semibold)
              outgoing.foregroundColor = .appBlue
              return outgoing
          }
        
//        config.imagePadding = 8
        config.imagePlacement = .trailing
        config.imageColorTransformer =
            UIConfigurationColorTransformer { incoming in
                return .appBlue
        }
        return config
    }
}
