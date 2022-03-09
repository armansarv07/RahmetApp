//
//  AuthAlertControllers.swift
//  Rahmet
//
//  Created by Arman on 09.03.2022.
//

import UIKit

class AuthAlertController: UIAlertController {
    init(title: String = "Error", description: String, actionText: String = "OK") {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.message = description
        let action = UIAlertAction(title: actionText, style: .default) { action in
            fatalError(description)
        }
        addAction(action)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
