//
//  SideMenuViewController.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import UIKit

fileprivate enum SideMenuSectionType {
    case profile, item, logout
}

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let sectionTypes = [
        SideMenuSectionType.profile, SideMenuSectionType.item, SideMenuSectionType.logout
    ]
    
    private let menuItems = [
        "Profile Saya", "Pengaturan"
    ]
    
    struct K {
        static let profileCell = "profileCell"
        static let itemCell = "itemCell"
        static let logoutCell = "logoutCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "MenuProfileTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: K.profileCell)
        tableView.register(UINib(nibName: "MenuItemTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: K.itemCell)
        tableView.register(UINib(nibName: "MenuLogoutTableViewCell", bundle: Bundle.main),
                           forCellReuseIdentifier: K.logoutCell)
    }
}

extension SideMenuViewController {
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sectionTypes[section]
        if sectionType == .item { return menuItems.count }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sectionTypes[indexPath.section]
        switch sectionType {
        case .profile:
            let aCell = tableView.dequeueReusableCell(withIdentifier: K.profileCell, for: indexPath)
            guard let cell = aCell as? MenuProfileTableViewCell else { return aCell }
            return cell
            
        case .item:
            let aCell = tableView.dequeueReusableCell(withIdentifier: K.itemCell, for: indexPath)
            guard let cell = aCell as? MenuItemTableViewCell else { return aCell }
            cell.label.text = menuItems[indexPath.row]
            return cell
            
        case .logout:
            let aCell = tableView.dequeueReusableCell(withIdentifier: K.logoutCell, for: indexPath)
            guard let cell = aCell as? MenuLogoutTableViewCell else { return aCell }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
