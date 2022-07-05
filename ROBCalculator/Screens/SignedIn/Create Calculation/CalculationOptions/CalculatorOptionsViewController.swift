//
//  CalculatorOptionsViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 11.04.2022.
//

import UIKit
import Combine

class CalculatorOptionsViewController: NiblessViewController {
    let viewModel: CalculatorOptionsViewModel
    let viewCreator: TableViewCellCreator = ViewCreator()
    var cancellables = Set<AnyCancellable>()
    
    lazy var closeButton: UIBarButtonItem = {
        let image = UIImage(named: "CloseMD")?.withRenderingMode(.alwaysTemplate)
        let view = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        view.target = viewModel
        view.action = #selector(CalculatorOptionsViewModel.closeFlow)
        view.tintColor = .appGray
        view.customView?.layer.cornerRadius = 24
        return view
    }()
    
    let titleView: UILabel = {
        let view = UILabel()
        view.font = .appFont(ofSize: 32, weight: .bold)
        view.textColor = .textColor
        view.text = "What do you want to calculate?"
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let subtitleView: UILabel = {
        let view = UILabel()
        view.font = .appFont(ofSize: 17, weight: .regular)
        view.textColor = .appGray
        view.text = "Select one or both options"
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let optionsView: CalculationOptionsView = {
        let view = CalculationOptionsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var continueButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.bigPrimary()
        config.title = "Continue"
        config.imagePlacement = .leading
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addAction(UIAction(handler: { [unowned self] _ in
            self.viewModel.goToInput()
        }), for: .touchUpInside)
        return view
    }()

    init(viewModel: CalculatorOptionsViewModel) {
        self.viewModel = viewModel
        super.init()
        view.backgroundColor = .appBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        subscribe()
        title = "New Calculation"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = nil
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.rightBarButtonItem = closeButton
    }
    
    func addSubviews() {
        view.addSubview(titleView)
        view.addSubview(subtitleView)
        view.addSubview(optionsView)
        view.addSubview(continueButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 12),
            subtitleView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            subtitleView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            
            optionsView.topAnchor.constraint(equalTo: subtitleView.bottomAnchor, constant: 32),
            optionsView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            optionsView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            
            continueButton.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            continueButton.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 54),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 16),
        ])
    }
    
    func subscribe() {
        optionsView.didSelectOperating = { [weak self] value in
            self?.viewModel.isOperating = value
        }
        
        optionsView.didSelectOwnership = { [weak self] value in
            self?.viewModel.isOwnership = value
        }
        
        optionsView.didSelectOwnershipFinancing = { [weak self] value in
            self?.viewModel.isOwnershipFinancing = value
        }
        
        viewModel.$isValid
            .sink { [weak self] isValid in
                self?.continueButton.isEnabled = isValid
            }
            .store(in: &cancellables)
    }
}
