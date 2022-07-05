//
//  Extension+UITableView.swift
//  CARL
//
//  Created by arkhyp on 30.09.2020.
//

import UIKit

func viewReuseIdentifier<T: UIView>(_ type: T.Type) -> String {
    var fullName: String = NSStringFromClass(type)
    if let name = fullName.split(separator: ".").last {
        fullName = String(name)
    }
    return fullName
}

//MARK: - DequeueReusable

extension UITableView {
    func dequeueReusableCell<T:UITableViewCell>(_ type: T.Type) -> T? {
        return self.dequeueReusableCell(withIdentifier: viewReuseIdentifier(type)) as? T
    }
    
    func dequeueReusableHeaderFooter<T:UIView>(_ type: T.Type) -> T? {
        return self.dequeueReusableHeaderFooterView(withIdentifier: viewReuseIdentifier(type)) as? T
    }
}

//MARK: - RegisterCell

extension UITableView {
    func registerCell<T: UIView>(_ type: T.Type) {
        self.register(type, forCellReuseIdentifier: viewReuseIdentifier(type))
    }
    
    func registerHeaderFooter<T: UIView>(_ type: T.Type) {
        self.register(type, forHeaderFooterViewReuseIdentifier: viewReuseIdentifier(type))
    }
}
