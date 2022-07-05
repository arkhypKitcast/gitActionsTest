//
//  CalcTypeViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import UIKit

class CalculationTypeSelectorViewController: NiblessViewController {
    
    lazy var buttonsView: EmptyHomeView = {
        let view = EmptyHomeView()
        view.flagView.isHidden = true
        view.titleView.isHidden = true
        view.subtitleView.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var closeSwipeGestue: UIGestureRecognizer = {
        let view = UISwipeGestureRecognizer()
        view.direction = .down
        view.addTarget(self, action: #selector(closeVC))
        return view
    }()
    
    lazy var closeTapGestue: UIGestureRecognizer = {
        let view = UITapGestureRecognizer()
        view.addTarget(self, action: #selector(closeVC))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        
//        view.addGestureRecognizer(closeSwipeGestue)
        view.addGestureRecognizer(closeTapGestue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buttonsView.alpha = 0
        buttonsView.transform = .init(translationX: 0, y: 200)
        self.view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .appBackground.withAlphaComponent(0.5)
            self.buttonsView.alpha = 1
            self.buttonsView.transform = .identity
        }
    }
    
    @objc
    func closeVC() {
        UIView.animate(withDuration: 0.3) {
            self.buttonsView.alpha = 0
            self.buttonsView.transform = .init(translationX: 0, y: 200)
            self.view.backgroundColor = .clear
        } completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    private func addSubviews() {
        view.addSubview(buttonsView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
