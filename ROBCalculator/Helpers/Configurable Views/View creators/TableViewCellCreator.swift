//
//  TableViewCreator.swift
//  SBApp
//
//  Created by Arkhyp Koshel on 27.02.2020.
//


import UIKit

typealias ConfigurableTableViewCell = UITableViewCell & ConfigurableView
typealias ConfigurableTableViewHeaderFooterView = UITableViewHeaderFooterView & ConfigurableView

protocol TableViewCellCreator {
    func dequeCell(
        _ data: ViewData,
        tableView: UITableView
    ) -> ConfigurableTableViewCell?
    
    func dequeHeaderFooterView(
        _ data: ViewData,
        tableView: UITableView
    ) -> ConfigurableTableViewHeaderFooterView?
}

extension TableViewCellCreator {
    func dequeCell(_ data: ViewData, tableView: UITableView) -> ConfigurableTableViewCell? {
        if let viewType = data.viewType as? ConfigurableTableViewCell.Type,
           let cell = tableView.dequeueReusableCell(viewType) as? ConfigurableTableViewCell {
            cell.configure(viewData: data)
            return cell
        }
        return nil
    }
    
    func dequeHeaderFooterView(_ data: ViewData, tableView: UITableView) -> ConfigurableTableViewHeaderFooterView? {
        if let viewType = data.viewType as? ConfigurableTableViewHeaderFooterView.Type,
           let view = tableView.dequeueReusableHeaderFooter(viewType) as? ConfigurableTableViewHeaderFooterView {
            view.configure(viewData: data)
            return view
        }
        return nil
    }
}
