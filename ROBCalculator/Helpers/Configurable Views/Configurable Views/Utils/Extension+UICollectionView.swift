//
//  Extension+UITableView.swift
//  CARL
//
//  Created by arkhyp on 30.09.2020.
//

import UIKit

//MARK: - DequeueReusable
extension UICollectionView {
    func dequeueReusableCell<T:UICollectionViewCell>(_ type: T.Type, indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: viewReuseIdentifier(type), for: indexPath) as? T
    }
    
    func dequeueReusableSupplementaryView<T:UICollectionReusableView>(_ type: T.Type, kind: String, indexPath: IndexPath) -> T? {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewReuseIdentifier(type), for: indexPath) as? T
    }    
}

//MARK: - RegisterCell

extension UICollectionView {
    func registerCell<T: UIView>(_ type: T.Type) {
        self.register(type, forCellWithReuseIdentifier: viewReuseIdentifier(type))
    }
    
    func registerSupplementaryView<T: UIView>(_ type: T.Type, kind: String) {
        self.register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewReuseIdentifier(type))
    }
}
