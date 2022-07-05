//
//  CollectionViewCellCreator.swift
//  CARL
//
//  Created by Arkhyp Koshel on 09.10.2020.
//

import UIKit

typealias ConfigurableCollectionViewCell = UICollectionViewCell & ConfigurableView
typealias ConfigurableCollectionReusableView  = UICollectionReusableView & ConfigurableView

protocol CollectionViewCellCreator {
    func dequeCell(
        _ data: ViewData,
        collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> ConfigurableCollectionViewCell?
}

extension CollectionViewCellCreator {
    func dequeCell(
        _ data: ViewData,
        collectionView: UICollectionView,
        indexPath: IndexPath
    ) -> ConfigurableCollectionViewCell? {
        
        if let viewType = data.viewType as? ConfigurableCollectionViewCell.Type,
           let cell = collectionView.dequeueReusableCell(
            viewType,
            indexPath: indexPath
           ) as? ConfigurableCollectionViewCell {
            cell.configure(viewData: data)
            return cell
        }
        return nil
    }
    
    func dequeReusableSupplementaryView(
        _ data: ViewData,
        collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: IndexPath
    ) -> ConfigurableCollectionReusableView? {
        
        guard let viewType = data.viewType as? ConfigurableCollectionReusableView.Type else {
            assertionFailure("Unexpected viewType")
            return nil
        }
        
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                viewType,
                kind: kind,
                indexPath: indexPath
        ) as? ConfigurableCollectionReusableView
        else {
            assertionFailure("view should be a type of ConfigurableCollectionReusableView")
            return nil
        }
        supplementaryView.configure(viewData: data)
        return supplementaryView
    }
}
