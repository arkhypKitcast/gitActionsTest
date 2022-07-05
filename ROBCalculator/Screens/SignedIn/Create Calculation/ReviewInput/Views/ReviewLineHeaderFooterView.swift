//  ReviewLineHeaderFooterView.swift
//  ROBCalculator
//
//  Created by arkhyp on 17.04.2022.
//  
//

import UIKit

struct ReviewLineViewData: ViewData {
    var viewType: ConfigurableView.Type = ReviewLineHeaderFooterView.self
    var hidden: Bool
}

class ReviewLineHeaderFooterView: ConfigurableTableViewHeaderFooterView {
    var isSectionHidden: Bool = false
    var topConstraint: NSLayoutConstraint!
    
    lazy var divider: DividerView = {
        let view = DividerView()
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
    }
    
    private func addConstraints() {
        topConstraint = divider.topAnchor.constraint(equalTo: contentView.topAnchor)
        let constraints = [
            topConstraint,
            divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ].compactMap({ $0 })
        
        constraints.forEach({ $0.priority = .init(rawValue: 999) })
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(viewData: ViewData) {
        guard let model = modelFor(ReviewLineViewData.self, viewData) else { return }
        isSectionHidden = model.hidden
        
        topConstraint.constant = isSectionHidden ? 0 : 20
    }
}
