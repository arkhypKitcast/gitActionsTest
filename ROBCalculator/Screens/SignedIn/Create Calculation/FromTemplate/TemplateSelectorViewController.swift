//
//  TemplateSelectorViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 11.04.2022.
//

import UIKit
import Combine

class TemplateSelectorViewController: NiblessViewController {
    let viewModel: TemplateSelectorViewModel
    let viewCreator: TableViewCellCreator = ViewCreator()
    var cancellables = Set<AnyCancellable>()
    
    lazy var closeButton: UIBarButtonItem = {
        let image = UIImage(named: "CloseMD")?.withRenderingMode(.alwaysTemplate)
        let view = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        view.target = viewModel
        view.action = #selector(TemplateSelectorViewModel.closeFlow)
        view.tintColor = .appGray
        view.customView?.layer.cornerRadius = 24
        return view
    }()
    
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
        view.registerCell(TemplateItemTableViewCell.self)
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
    
    init(viewModel: TemplateSelectorViewModel) {
        self.viewModel = viewModel
        super.init()
        view.backgroundColor = .appBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        subscribe()
        title = "Templates"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyView.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.rightBarButtonItem = closeButton
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
    
    func subscribe() {
        viewModel.$state
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        searchView.searchField.delegate = self
        searchView.searchField.addTarget(self, action: #selector(didChangeSearchText), for: .editingChanged)
    }
    
    @objc
    func didChangeSearchText() {
        viewModel.filterString = searchView.searchField.text
    }
}

extension TemplateSelectorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return true
    }
}

extension TemplateSelectorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectAt(ind: indexPath.row)
    }
}

extension TemplateSelectorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.templates.count
        emptyView.isHidden = count != 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let template = viewModel.templates[indexPath.row]
        let data = TemplateItemViewData(
            image: template.image,
            name: template.title) { [weak self] in
                self?.viewModel.selectAt(ind: indexPath.row)
            }
        return viewCreator.dequeCell(data, tableView: tableView)!
    }
}
