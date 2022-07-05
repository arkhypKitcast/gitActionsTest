//
//  FinalDetailsViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 18.04.2022.
//

import Foundation
import UIKit

class FinalDetailsViewController: NiblessViewController {
    let viewModel: FinalDetailsViewModel
    let viewCreator: TableViewCellCreator = ViewCreator()
    var hiddenSections: [Int] = []
    
    lazy var saveButton: UIBarButtonItem = {
        let image = UIImage(named: "CloseMD")?.withRenderingMode(.alwaysTemplate)
        let view = UIBarButtonItem(systemItem: .save)//(image: image, style: .plain, target: nil, action: nil)
        view.target = viewModel
        view.action = #selector(ReviewInputViewModel.closeFlow)
        view.tintColor = .appGray
        view.customView?.layer.cornerRadius = 24
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        
//        view.sectionFooterHeight = 1
        view.registerCell(PlaneHeaderTableViewCell.self)
        view.registerCell(DetailDataTableViewCell.self)
        
        view.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        view.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        
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
            
        }), for: .touchUpInside)
        return view
    }()
    
    init(viewModel: FinalDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
        view.backgroundColor = .appBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        title = "Details"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension FinalDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        viewModel.selectAt(ind: indexPath.row)
    }
}

extension FinalDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var data: ViewData
        switch indexPath.row {
        case 0:
            data = PlaneHeaderViewData(
                image: UIImage(named: "plane76"),
                planeName: "1974 Piper PA31-350 Navajo Chieftain",
                registerNumber: "N808SM") {
                
            } hiedAction: {
                
            }
        default:
            data = DetailDataViewData(
                title: "Operating Costs",
                values: [
                    (title: "Fuel", value: "$38"),
                    (title: "Oil Changes / Oil Adds", value: "$38"),
                    (title: "Engine Reserve", value: "$16,1"),
                    (title: "Total Variable Costs per Hour", value: "$41,13"),
                ])
        }

        return viewCreator.dequeCell(data, tableView: tableView)!
    }
    
    func toggleHide() {
        
    }
}
