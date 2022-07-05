//
//  FirstWelcomeView.swift
//  ROBCalculator
//
//  Created by arkhyp on 22.03.2022.
//

import Foundation
import UIKit

class FirstWelcomeView: UIView, WelcomeStepView {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .textColor
        view.text = "Calculate from template\nor from scratch"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = .appFont(ofSize: 24, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var newCalculationView: UIView = {
        let view = UIButton()
        var config = UIButton.Configuration.bigPrimary()
        config.title = "New Calculation"
        config.image = UIImage(named: "Add_Plus")?.withRenderingMode(.alwaysTemplate)
        config.imagePadding = 8
        config.imagePlacement = .leading
        config.cornerStyle = .large
        config.buttonSize = .medium
        config.baseBackgroundColor = .appTutorialButton
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .appFont(ofSize: 14, weight: .semibold)
            outgoing.foregroundColor = .textColor
            return outgoing
        }
    
        config.imageColorTransformer =
            UIConfigurationColorTransformer { incoming in
                return .textColor
        }
        view.configuration = config
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var useTemplateView: UIView = {
        let view = UIButton()
        var config = UIButton.Configuration.bigPrimary()
        config.title = "Use Template"
        config.image = UIImage(named: "Template")?.withRenderingMode(.alwaysTemplate)
        config.imagePadding = 8
        config.imagePlacement = .top
        config.cornerStyle = .large
        config.buttonSize = .medium
        config.baseBackgroundColor = .appTutorialButton
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
        view.configuration = config
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var fromScratchView: UIView = {
        let view = UIButton()
        var config = UIButton.Configuration.bigPrimary()
        config.title = "From Scratch"
        config.image = UIImage(named: "Add_Plus_Circle")?.withRenderingMode(.alwaysTemplate)
        config.imagePadding = 8
        config.imagePlacement = .top
        config.cornerStyle = .large
        config.buttonSize = .medium
        config.baseBackgroundColor = .appTutorialButton
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
        view.configuration = config
        
        view.layer.shadowColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.1).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 68
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIImageView()
        view.image = UIImage(named: "Line1")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
        prepareForAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(lineView)
        addSubview(newCalculationView)
        addSubview(useTemplateView)
        addSubview(fromScratchView)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        let newCalculationViewWidth = newCalculationView.widthAnchor.constraint(equalToConstant: 295)
        newCalculationViewWidth.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            
            //
            newCalculationView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            newCalculationView.heightAnchor.constraint(equalToConstant: 46),
            newCalculationView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 32),
            newCalculationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            newCalculationViewWidth,
            
            //
            useTemplateView.widthAnchor.constraint(equalTo: newCalculationView.widthAnchor, multiplier: 0.5),
            useTemplateView.heightAnchor.constraint(equalToConstant: 92),
            useTemplateView.topAnchor.constraint(equalTo: newCalculationView.bottomAnchor, constant: 70),
            useTemplateView.leadingAnchor.constraint(equalTo: newCalculationView.leadingAnchor, constant: -12),
            //
            fromScratchView.widthAnchor.constraint(equalTo: newCalculationView.widthAnchor, multiplier: 0.5),
            fromScratchView.heightAnchor.constraint(equalToConstant: 92),
            fromScratchView.topAnchor.constraint(equalTo: useTemplateView.bottomAnchor, constant: -24),
            fromScratchView.leadingAnchor.constraint(equalTo: useTemplateView.trailingAnchor, constant: -22),
            //
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            //
            lineView.trailingAnchor.constraint(equalTo: newCalculationView.trailingAnchor, constant: 24),
            lineView.bottomAnchor.constraint(equalTo: fromScratchView.topAnchor, constant: 36),
            lineView.centerYAnchor.constraint(equalTo: newCalculationView.centerYAnchor, constant: 32),
            
        ])
    }
    
    func prepareForAnimation() {
        self.titleLabel.alpha = 0
        self.titleLabel.transform = .init(translationX: 0, y: -200)
        
        self.newCalculationView.alpha = 0
        self.newCalculationView.transform = .init(translationX: 0, y: -200)
        
        self.useTemplateView.alpha = 0
        self.useTemplateView.transform = .init(translationX: 0, y: -200)
        
        self.fromScratchView.alpha = 0
        self.fromScratchView.transform = .init(translationX: 0, y: -400)
        
        self.lineView.alpha = 0
        
    }
    
    func startAnimation(completion: @escaping () -> ()) {
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.allowUserInteraction]) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.titleLabel.alpha = 1
                self.titleLabel.transform = .identity
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.newCalculationView.alpha = 1
                self.newCalculationView.transform = .identity
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.useTemplateView.alpha = 1
                self.useTemplateView.transform = .identity
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.fromScratchView.alpha = 1
                self.fromScratchView.transform = .identity
                self.lineView.alpha = 1
            }
            
        } completion: { _ in
            completion()
        }
    }
}
