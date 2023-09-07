//
//  FormLabel.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import UIKit

class FormLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
    
    private func configUI() {
        textColor = Theme.Color.navy
        font = UIFont(name: Theme.FontName.semiBold, size: 16.0)
    }
}
