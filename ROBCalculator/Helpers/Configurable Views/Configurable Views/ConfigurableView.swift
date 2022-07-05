//
//  ConfigurableView.swift
//  CARL
//
//  Created by arkhyp on 30.09.2020.
//

import UIKit

protocol ConfigurableView: UIView {
    func configure(viewData: ViewData)
}

protocol ViewData {
    var viewType: ConfigurableView.Type { get }
}

extension ConfigurableView {
    func modelFor<T: ViewData>(_ type: T.Type, _ viewData: ViewData) -> T? {
        return viewData as? T
    }
}
