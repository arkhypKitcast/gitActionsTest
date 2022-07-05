//
//  DictionaryViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 10.04.2022.
//

import UIKit

class DictionaryViewController: NiblessViewController {
    let viewModel: DictionaryViewModel
    let viewCreator: TableViewCellCreator = ViewCreator()
    
    lazy var searchView: SearchView = {
        let view = SearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emptyView: EmptyTableView = {
        let view = EmptyTableView()
        view.titleView.text = "Nothing Found"
        view.subtitleView.text = "We can't find what you're looking for.\nTry again with other keywords."
        view.flagView.image = UIImage(named: "Search")?.withTintColor(.appGray3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.registerHeaderFooter(ArticlesHeaderFooterView.self)
        view.registerCell(ArticleListTableViewCell.self)
        view.registerHeaderFooter(DictionaryHeaderFooterView.self)
        view.registerCell(DictionaryItemTableViewCell.self)
        view.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        view.dataSource = self
        view.delegate = self
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: DictionaryViewModel) {
        self.viewModel = viewModel
        super.init()
        view.backgroundColor = .appBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        title = "Dictionary"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyView.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func addSubviews() {
        view.addSubview(searchView)
        view.addSubview(lineView)
        view.addSubview(tableView)
        view.addSubview(emptyView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            lineView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
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

extension DictionaryViewController: UITableViewDelegate {
    
}

extension DictionaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 10
        emptyView.isHidden = count != 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = DictionaryItemViewData(
            title: "1",
            text: "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.",
            expanded: nil,
            indexPath: nil,
            didExpandAction: nil)
        return viewCreator.dequeCell(data, tableView: tableView)!
    }
}
