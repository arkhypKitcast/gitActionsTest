//
//  SettingsViewContrroller.swift
//  ROBCalculator
//
//  Created by arkhyp on 26.03.2022.
//

import Foundation
import UIKit
import Combine

class SettingsViewController: NiblessViewController {
    var cancellables = Set<AnyCancellable>()
    let viewModel: SettingsViewModel
    let viewCreator: TableViewCellCreator = ViewCreator()
    
    lazy var gradientView: GradientView = {
        let view = GradientView()
        view.layer.cornerRadius = 22
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.registerCell(AppLinkTableViewCell.self)
        view.registerCell(SettingLinkTableViewCell.self)
        view.dataSource = self
        view.delegate = self
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.separatorColor = .appGray
        view.separatorStyle = .singleLine
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init()
        view.backgroundColor = .appBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        subscribe()
        title = "Settings"
        view.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func addSubviews() {
        view.addSubview(gradientView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -1),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 1),
            gradientView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func subscribe() {
        viewModel.$settings
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewCreator.dequeCell(viewModel.settings[indexPath.section][indexPath.row], tableView: tableView)!
    }
}
