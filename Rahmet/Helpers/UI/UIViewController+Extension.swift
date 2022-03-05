//
//  UIViewController+Extension.swift
//  Rahmet
//
//  Created by Arman on 09.02.2022.
//

import UIKit

extension UIViewController {
    
    func configure<T: ConfigurableCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)") }
        cell.configure(with: value)
        return cell
    }
}
