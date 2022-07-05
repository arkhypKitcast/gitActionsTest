//
//  WelcomeViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 22.03.2022.
//

import Foundation
import UIKit
import Combine

class WelcomeViewController: NiblessViewController {
    private let viewModel: WelcomeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    let views: [WelcomeStepView] = [FirstWelcomeView(), SecondWelcomeView(), ThirdWelcomeView()]
    var currentView: UIView?

    lazy var pagePlayerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.bigPrimary()
        config.title = "Next"
        config.image = UIImage(named: "Chevron_Right")?.withRenderingMode(.alwaysTemplate)
        view.configuration = config
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        addSubviews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribe()
    }
    
    private func addSubviews() {
        view.addSubview(pagePlayerView)
        view.addSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pagePlayerView.topAnchor.constraint(equalTo: view.topAnchor),
            pagePlayerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pagePlayerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            nextButton.topAnchor.constraint(equalTo: pagePlayerView.bottomAnchor, constant: 8),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
        ])
    }
    
    private func subscribe() {
        nextButton.addAction(
            UIAction(handler: { [unowned self] _ in
                self.viewModel.next()
            }),
            for: .touchUpInside
        )
        
        viewModel.$currentPage.sink { [weak self] newPage in
            self?.presentPage(newPage)
        }.store(in: &cancellables)
    }
    
    private func presentPage(_ index: Int) {
        let newView = views[index]
        newView.frame = pagePlayerView.bounds
        newView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        newView.transform = .init(translationX: newView.frame.maxX, y: 0)
        nextButton.isEnabled = false
        animateNextButton(for: index)
        UIView.transition(
            with: pagePlayerView,
            duration: 0.33,
            options: [.curveEaseOut],
            animations: {
                newView.transform = .identity
                self.currentView?.transform = .init(translationX: -newView.frame.maxX, y: 0)
                self.pagePlayerView.addSubview(newView)
        }) { _ in
            self.currentView?.removeFromSuperview()
            self.currentView = nil
            self.currentView = newView
            newView.startAnimation {
                self.nextButton.isEnabled = true
                self.nextButton.alpha = 1
            }
        }
    }
    
    private func animateNextButton(for page: Int) {
        guard page == 0 else { return }
        nextButton.isEnabled = true
        let y = view.bounds.maxY - nextButton.frame.minY
        nextButton.transform = .init(translationX: 0, y: y)
        
        UIView.animate(withDuration: 0.5, delay: 1, options: []) {
            self.nextButton.transform = .identity
            self.nextButton.alpha = 1
        } completion: { _ in
        }
    }
}
