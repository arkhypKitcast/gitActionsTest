//
//  HomeViewController.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//

import Combine
import UIKit

class HomeViewController: NiblessViewController {
    let viewModel: HomeViewModel
    let viewCreator: TableViewCellCreator = ViewCreator()
    var cancellables = Set<AnyCancellable>()
    
    lazy var gradientView: GradientView = {
        let view = GradientView()
        view.layer.cornerRadius = 22
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.registerCell(HomeTableViewCell.self)
        view.registerCell(RobResultViewTableViewCell.self)
        view.registerHeaderFooter(HomeHeaderFooterView.self)
        view.dataSource = self
        view.delegate = self
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
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
    
    lazy var addCalculationButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.bigPrimary(view)
        config.image = UIImage(named: "Add_Plus")?.withRenderingMode(.alwaysTemplate)
        config.title = "New Calculation"
        config.imagePlacement = .leading
        view.configuration = config
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addAction(UIAction(handler: { [unowned self] _ in
            self.presentNewCalc()
        }), for: .touchUpInside)
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
        
        view.backgroundColor = .appBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        subscribe()
        title = "Home"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func addSubviews() {
        view.addSubview(gradientView)
        view.addSubview(tableView)
        view.addSubview(bottomGradient)
        view.addSubview(addCalculationButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            bottomGradient.heightAnchor.constraint(equalToConstant: 80),
            bottomGradient.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomGradient.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomGradient.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            
            addCalculationButton.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -24),
            addCalculationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addCalculationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func subscribe() {
        viewModel.$calclationResults.sink { [weak self] results in
            self?.addCalculationButton.isHidden = !(results.count > 1)
        }
        .store(in: &cancellables)
    }
    
    func presentNewCalc() {
        let vc = CalculationTypeSelectorViewController()
        vc.buttonsView.scratchButton.addAction(UIAction(handler: { [unowned self] _ in
            vc.dismiss(animated: true) {
                self.viewModel.openCalculation(type: .new)
            }
        }), for: .touchUpInside)
        vc.buttonsView.templateButton.addAction(UIAction(handler: { [unowned self] _ in
            vc.dismiss(animated: true) {
                self.viewModel.openCalculation(type: .template)
            }
        }), for: .touchUpInside)
        vc.modalPresentationStyle = .overCurrentContext
        tabBarController?.present(vc, animated: false, completion: nil)
    }
    
    func subscribeHomeCell(_ cell: HomeTableViewCell) {
        cell.settingsButton.addAction(UIAction(handler: { [unowned self] _ in
            self.viewModel.openSettings()
        }), for: .touchUpInside)
        
        cell.emptyView.scratchButton.addAction(UIAction(handler: { [unowned self] _ in
            self.viewModel.openCalculation(type: .new)
        }), for: .touchUpInside)
        
        cell.emptyView.templateButton.addAction(UIAction(handler: { [unowned self] _ in
            self.viewModel.openCalculation(type: .template)
        }), for: .touchUpInside)
    }
}


extension HomeViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let space = 250.0
        let radius = 22.0
        
        if scrollView.contentOffset.y > space {
            gradientView.transform = .init(translationX: 0, y: -space)
        } else if scrollView.contentOffset.y < 0 {
            gradientView.transform = .identity
        } else {
            let y = -scrollView.contentOffset.y
            gradientView.transform = .init(translationX: 0, y: y)
        }
        
        let ratio = gradientView.frame.maxY / space
        gradientView.layer.cornerRadius = ratio * radius
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            let count = viewModel.calclationResults.count
            if count > 1 {
                return count - 1
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = viewCreator.dequeCell(HomeViewData(), tableView: tableView) as! HomeTableViewCell
            subscribeHomeCell(cell)
            return cell
        default:
            return viewCreator.dequeCell(RobResultViewData(), tableView: tableView)!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            let count = viewModel.calclationResults.count
            if count > 1 {
                let hederData = HomeHeaderViewData()
                return viewCreator.dequeHeaderFooterView(hederData, tableView: tableView)
            }
            return nil
        }
    }
}
