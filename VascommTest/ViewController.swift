//
//  ViewController.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let appDelegate,
            let loginViewController = appDelegate.container.resolve(LoginViewController.self) {
            let navController = UINavigationController(rootViewController: loginViewController)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true)
        }
    }
}

