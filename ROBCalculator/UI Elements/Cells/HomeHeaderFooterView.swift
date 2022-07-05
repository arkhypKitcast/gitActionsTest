//  HomeHeaderFooterView.swift
//  ROBCalculator
//
//  Created by arkhyp on 25.03.2022.
//  
//

import UIKit

struct HomeHeaderViewData: ViewData {
    var viewType: ConfigurableView.Type = HomeHeaderFooterView.self
    var title: String = "Latest Calculations"
}

class HomeHeaderFooterView: ConfigurableTableViewHeaderFooterView {
    lazy var divider: DividerView = {
        let view = DividerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.font = .appFont(ofSize: 24, weight: .bold)
        view.textColor = .textColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(divider)
        contentView.addSubview(titleView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: contentView.topAnchor),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16),
        ])
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(HomeHeaderViewData.self, viewData) else { return }
        titleView.text = model.title
    }
}
