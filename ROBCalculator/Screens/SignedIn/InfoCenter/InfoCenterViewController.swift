//
//  InfoCenterViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 10.04.2022.
//

import Foundation
import UIKit

class InfoCenterViewController: NiblessViewController {
    let viewModel: InfoCenterViewModel
    let viewCreator: TableViewCellCreator = ViewCreator()
    
    lazy var emptyView: EmptyTableView = {
        let view = EmptyTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var expanded: [IndexPath] = []

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.registerHeaderFooter(ArticlesHeaderFooterView.self)
        view.registerCell(ArticleListTableViewCell.self)
        view.registerHeaderFooter(DictionaryHeaderFooterView.self)
        view.registerCell(DictionaryItemTableViewCell.self)
        view.dataSource = self
        view.delegate = self
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: InfoCenterViewModel) {
        self.viewModel = viewModel
        super.init()
        view.backgroundColor = .appBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        title = "Info Center"
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

extension InfoCenterViewController: UITableViewDelegate {
    
}

extension InfoCenterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var data: ViewData
        switch indexPath.section {
        case 0:
            data = ArticleListViewData(
                articles: [
                    ArticleViewData(title: "Amet minim mollit non deserunt ullamco est sit", formattedDate: "2 March 2022", image: ""),
                    ArticleViewData(title: "", formattedDate: "", image: ""),
                    ArticleViewData(title: "", formattedDate: "", image: ""),
                ], didSelectArticle: { article in
                print(article)
            })
        default:
            data = DictionaryItemViewData(
                title: "1",
                text: "Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.",
                expanded: expanded.contains(indexPath),
                indexPath: indexPath,
                didExpandAction: { ind, _ in
                    if self.expanded.contains(ind) {
                        self.expanded.removeAll(where: { $0 == ind })
                    } else {
                        self.expanded.append(ind)
                    }
                    self.tableView.reloadRows(at: [ind], with: .automatic)
                })
        }
        return viewCreator.dequeCell(data, tableView: tableView)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let data = ArticlesViewData()
            return viewCreator.dequeHeaderFooterView(data, tableView: tableView)
        case 1:
            let data = DictionaryViewData() { [weak self] in
                self?.viewModel.showDictionary()
            }
            return viewCreator.dequeHeaderFooterView(data, tableView: tableView)
        default:
            return nil
        }
    }
}
