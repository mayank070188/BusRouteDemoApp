//
//  UIAlertController+Utils.swift
//  BusRoute
//
//  Created by Mayank Mathur on 28/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import UIKit

extension UIAlertController {
    typealias Completion = ()->()
    
    static func showAlert(title: String = "", message: String = "", buttonOneTitle: String? = nil, inViewController: UIViewController? = nil, okAction: Completion? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let buttonTitle = buttonOneTitle {
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { ( _: UIAlertAction) -> Void in
                okAction?()
            }))
        }
        DispatchQueue.main.async {
            inViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
