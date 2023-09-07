//
//  Alert.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import UIKit

struct Alert {
    var title: String?
    var message: String?
    var actions: [UIAlertAction]?
    
    init(title: String? = nil, message: String? = nil, actions: [UIAlertAction]? = nil) {
        self.title = title
        self.message = message
        self.actions = actions
    }
    
    func show(parentViewController viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                alertController.addAction(action)
            }
        }
        viewController.present(alertController, animated: true)
    }
    
    // MARK: - Custom Alert
    
    static func basicAlert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)? = nil) -> Alert {
        let action = UIAlertAction(title: "Ya", style: .default, handler: handler)
        return Alert(title: title, message: message, actions: [action])
    }
    
    static func logoutAlert(handler: ((UIAlertAction) -> Void)? = nil) -> Alert {
        let yesAction = UIAlertAction(title: "Ya", style: .destructive, handler: handler)
        let noAction = UIAlertAction(title: "Tidak", style: .cancel)
        return Alert(title: "Keluar", message: "Apakah anda ingin keluar?", actions: [yesAction, noAction])
    }
}
