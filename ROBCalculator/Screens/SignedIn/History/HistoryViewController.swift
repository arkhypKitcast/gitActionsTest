//
//  HistoryViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 26.03.2022.
//

import UIKit

class HistoryViewController: NiblessViewController {
    let viewModel: HistoryViewModel
    let viewCreator: TableViewCellCreator = ViewCreator()
    
    lazy var emptyView: EmptyTableView = {
        let view = EmptyTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.registerCell(RobResultViewTableViewCell.self)
        view.dataSource = self
        view.delegate = self
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init()
        view.backgroundColor = .appBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        title = "History"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyView.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(emptyView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyView.topAnchor.constraint(equalTo: tableView.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            
        ])
    }
}

extension HistoryViewController: UITableViewDelegate {
    
}

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewCreator.dequeCell(RobResultViewData(), tableView: tableView)!
    }
}
