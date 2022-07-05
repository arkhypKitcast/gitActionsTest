//
//  ThirdWelcomeView.swift
//  ROBCalculator
//
//  Created by arkhyp on 23.03.2022.
//

import Foundation
import UIKit

class ThirdWelcomeView: UIView, WelcomeStepView {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .textColor
        view.text = "Check your results on the\nhome page"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = .appFont(ofSize: 24, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var firstResultView: UIView = {
        let view = RobResultView()
        view.headerView.titleView.titleView.text = "1974 Piper PA31-350 Navajo Chieftain"
        view.headerView.titleView.subtitleView.text = "N808SM"
        view.headerView.imageView.image = UIImage(named: "piperImage")

        view.operatingCostView.setValues([
            RowInfo(title: "Costs Per Hour", value: "$41,13")
        ])
        
        view.ownershipCostView.isHidden = true
        view.robCalculationResult.isHidden = true
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var secondResultView: UIView = {
        let view = RobResultView()
        view.headerView.titleView.titleView.text = "1977 Cessna 182Q"
        view.headerView.titleView.subtitleView.isHidden = true
        view.headerView.imageView.image = nil
        view.headerView.imageView.isHidden = true
        
        view.operatingCostView.setValues([
            RowInfo(title: "Costs Per Hour", value: "$41,13")
        ])
        
        view.ownershipCostView.setValues([
            RowInfo(title: "Total Fixed Costs Per Year", value: "$7145,50"),
            RowInfo(title: "Fixed Cost Per Month", value: "$520,45"),
        ])
        view.isUserInteractionEnabled = false
        
        view.layer.shadowColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 0.1).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 68
        view.layer.shadowOffset = CGSize(width: 0, height: 4)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIImageView()
        view.image = UIImage(named: "Line3")
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
        addSubview(titleLabel)
        addSubview(firstResultView)
        addSubview(secondResultView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        prepareForAnimation()
    }
    
    func setupConstraints() {
        
        let secondViewWidth = secondResultView.widthAnchor.constraint(equalToConstant: 350)
        secondViewWidth.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            
            lineView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 70),
            lineView.bottomAnchor.constraint(equalTo: firstResultView.bottomAnchor, constant: -80),
            
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            firstResultView.centerYAnchor.constraint(equalTo: centerYAnchor),
            firstResultView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            firstResultView.centerXAnchor.constraint(equalTo: centerXAnchor),
            firstResultView.widthAnchor.constraint(equalTo: secondResultView.widthAnchor),
            
            secondResultView.bottomAnchor.constraint(equalTo: firstResultView.bottomAnchor),
            secondResultView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            secondResultView.centerXAnchor.constraint(equalTo: centerXAnchor),
            secondViewWidth,
            
        ])
    }
    
    func prepareForAnimation() {
        self.firstResultView.alpha = 0
        self.firstResultView.layer.anchorPoint = CGPoint(x: 0, y: 1)
        self.firstResultView.transform = CGAffineTransform(scaleX: 0.65, y: 0.65).concatenating(CGAffineTransform.init(translationX: -45, y: 100))
        
        self.secondResultView.alpha = 0
        self.secondResultView.layer.anchorPoint = CGPoint(x: 0, y: 1)
        self.secondResultView.transform = CGAffineTransform(scaleX: 0.65, y: 0.65).concatenating(CGAffineTransform.init(translationX: -45, y: 100))
        
        self.lineView.alpha = 0
    }
    
    func startAnimation(completion: @escaping () -> ()) {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.allowUserInteraction]) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.firstResultView.alpha = 1
                self.firstResultView.transform = CGAffineTransform(scaleX: 0.65, y: 0.65).concatenating(CGAffineTransform(rotationAngle: -0.48)).concatenating(CGAffineTransform.init(translationX: -45, y: 100))

            }

            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 1) {
                self.secondResultView.alpha = 1
                self.secondResultView.transform = CGAffineTransform(scaleX: 0.65, y: 0.65).concatenating(CGAffineTransform(rotationAngle: -0.22)).concatenating(CGAffineTransform.init(translationX: -45, y: 100))
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.lineView.alpha = 1
            }
        } completion: { _ in
            completion()
        }
    }

}
