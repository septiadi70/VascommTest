//
//  HomeViewController.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var sideMenuButton: UIBarButtonItem = {
        let image = UIImage(named: "dashicons_menu")?.withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(image: image,
                                   style: .plain,
                                   target: self,
                                   action: #selector(sideMenuButtonTapped(_:)))
        return item
    }()
    
    lazy var cartButton: UIBarButtonItem = {
        let image = UIImage(named: "shopping-cart 1")?.withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(image: image,
                                   style: .plain,
                                   target: self,
                                   action: #selector(cartButtonTapped(_:)))
        return item
    }()
    
    lazy var notifButton: UIBarButtonItem = {
        let image = UIImage(named: "notif-new")?.withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(image: image,
                                   style: .plain,
                                   target: self,
                                   action: #selector(notifButtonTapped(_:)))
        return item
    }()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = sideMenuButton
        navigationItem.rightBarButtonItems = [notifButton, cartButton]
    }

}

extension HomeViewController {
    @objc func sideMenuButtonTapped(_ sender: UIBarButtonItem) {
        guard let viewController = appDelegate?.container.resolve(SideMenuViewController.self)
        else { return }
        
        viewController.modalPresentationStyle = .custom
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(viewController, animated: false, completion: nil)
    }
    
    @objc func cartButtonTapped(_ sender: UIBarButtonItem) {}
    
    @objc func notifButtonTapped(_ sender: UIBarButtonItem) {}
}
