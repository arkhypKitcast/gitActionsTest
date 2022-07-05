//
//  ViewCreator.swift
//  CARL
//
//  Created by arkhyp on 21.10.2020.
//

import UIKit

protocol ConfigurableViewCreator {
    func configurableView(_ data: ViewData) -> ConfigurableView
}

extension ConfigurableViewCreator {
    func configurableView(_ data: ViewData) -> ConfigurableView {
        let view = data.viewType.init()
        view.configure(viewData: data)
        return view
    }
}

class ViewCreator: ConfigurableViewCreator, TableViewCellCreator, CollectionViewCellCreator {}
