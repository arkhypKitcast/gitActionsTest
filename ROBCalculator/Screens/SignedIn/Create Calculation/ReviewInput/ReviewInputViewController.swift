//
//  ReviewInputViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 16.04.2022.
//

import UIKit

class ReviewInputViewController: NiblessViewController {
    let viewModel: ReviewInputViewModel
    let viewCreator: TableViewCellCreator = ViewCreator()
    var hiddenSections: [Int] = []
    
    lazy var closeButton: UIBarButtonItem = {
        let image = UIImage(named: "CloseMD")?.withRenderingMode(.alwaysTemplate)
        let view = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        view.target = viewModel
        view.action = #selector(ReviewInputViewModel.closeFlow)
        view.tintColor = .appGray
        view.customView?.layer.cornerRadius = 24
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        
//        view.sectionFooterHeight = 1
        
        view.registerHeaderFooter(ReviewLineHeaderFooterView.self)
        view.registerHeaderFooter(ReviewHeaderFooterView.self)
        view.registerCell(ReviewQuestionTableViewCell.self)
        
        view.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        view.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        view.dataSource = self
        view.delegate = self
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomGradient: GradientView = {
        let view = GradientView()
        view.colors = [
            UIColor.appBackground.withAlphaComponent(0),
            UIColor.appBackground
        ]
        view.gradientLayer.locations = [0, 1]
        view.gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        view.gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        view.gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 0, ty: 0))
        view.isHidden = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var calculationButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.bigPrimary(view)
        config.title = "Calculate"
        config.imagePlacement = .leading
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addAction(UIAction(handler: { [unowned self] _ in
            self.viewModel.approveQuestions()
        }), for: .touchUpInside)
        return view
    }()
    
    init(viewModel: ReviewInputViewModel) {
        self.viewModel = viewModel
        super.init()
        view.backgroundColor = .appBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        title = "Review"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.rightBarButtonItem = closeButton
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(bottomGradient)
        view.addSubview(calculationButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            bottomGradient.heightAnchor.constraint(equalToConstant: 80),
            bottomGradient.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomGradient.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomGradient.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            
            calculationButton.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -24),
            calculationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            calculationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculationButton.heightAnchor.constraint(equalToConstant: 54),
        ])
    }
}

extension ReviewInputViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        viewModel.selectAt(ind: indexPath.row)
        viewModel.editQuestion(at: 0)
    }
}

extension ReviewInputViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hiddenSections.contains(section) {
            return 0
        }
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = ReviewQuestionViewData(title: "How much do you pay for a gallon of aviation fuel?",
                                          value: "10")
        return viewCreator.dequeCell(data, tableView: tableView)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var data: ViewData
        
        switch section {
        case 0:
            data = ReviewViewData(title: "Operating Cost", hide: hiddenSections.contains(section), hideToggleAction: { [weak self] in
                self?.toggleSection(section: section)
                tableView.reloadSections([section], with: .automatic)
            })
        case 1:
            data = ReviewViewData(title: "Ownership Cost", hide: hiddenSections.contains(section), hideToggleAction: { [weak self] in
                self?.toggleSection(section: section)
                tableView.reloadSections([section], with: .automatic)
                print("section \(section)")
            })
        default:
            data = ReviewViewData(title: "Financing", hide: hiddenSections.contains(section), hideToggleAction: { [weak self] in
                self?.toggleSection(section: section)
                tableView.reloadSections([section], with: .automatic)
                print("section \(section)")
            })
        }
        
        return viewCreator.dequeHeaderFooterView(data, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let data = ReviewLineViewData(hidden: hiddenSections.contains(section))
        return viewCreator.dequeHeaderFooterView(data, tableView: tableView)
    }
    
    func toggleSection(section: Int) {
        if hiddenSections.contains(section) {
            hiddenSections = hiddenSections.filter({ section != $0 })
        } else {
            hiddenSections.append(section)
        }
    }
}
