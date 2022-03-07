//
//  UCollectionView+Extension.swift
//  Rahmet
//
//  Created by Arman on 07.03.2022.
//

import UIKit

extension UICollectionView {
    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}
