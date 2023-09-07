//
//  MenuLogoutTableViewCell.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import UIKit

protocol MenuLogoutTableViewCellDelegate: AnyObject {
    func menuLogoutTableViewCellDidButtonTapped(at cell: MenuLogoutTableViewCell)
}

class MenuLogoutTableViewCell: UITableViewCell {
    weak var delegate: MenuLogoutTableViewCellDelegate?
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.menuLogoutTableViewCellDidButtonTapped(at: self)
    }
}
