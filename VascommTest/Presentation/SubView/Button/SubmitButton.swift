//
//  SubmitButton.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import UIKit

class SubmitButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .right
        
        let availableSpace = bounds.inset(by: contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth / 2)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8.0)
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 5
    }
    
    private func configUI() {
        backgroundColor = Theme.Color.navy
        tintColor = .white
        
        layer.cornerRadius = 8.0
        
        setImage(UIImage(systemName: "arrow.right"), for: .normal)
        
        titleLabel?.font = UIFont(name: Theme.FontName.semiBold, size: 16.0)
    }
}
