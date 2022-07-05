//  RobResultViewTableViewCell.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//  
//

import UIKit

struct RobResultViewData: ViewData {
    var viewType: ConfigurableView.Type = RobResultViewTableViewCell.self
}

class RobResultViewTableViewCell: ConfigurableTableViewCell {
    
    lazy var resultView: RobResultView = {
        let view = RobResultView()
        
        view.headerView.titleView.titleView.text = "1974 Piper PA31-350 Navajo Chieftain"
        view.headerView.titleView.subtitleView.text = "N808SM"
        view.headerView.imageView.image = UIImage(named: "piperImage")
        
        view.operatingCostView.setValues([
            RowInfo(title: "Costs Per Hour", value: "$41,13")
        ])
        
        view.ownershipCostView.setValues([
            RowInfo(title: "Total Fixed Costs Per Year", value: "$7145,50"),
            RowInfo(title: "Fixed Cost Per Month", value: "$520,45"),
        ])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(resultView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            resultView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            resultView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            resultView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure(viewData: ViewData) {
        guard let _ = modelFor(RobResultViewData.self, viewData) else { return }
    }
}
