//
//  HUDLoadable.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import UIKit

fileprivate struct K {
    fileprivate static let loadingViewTag = 1234
}

protocol HUDLoadable: AnyObject {
    func showLoading(_ text: String?)
    func hideLoading()
}

extension HUDLoadable where Self: UIViewController {
    func showLoading(_ text: String?) {
        let hud: HUDView = HUDView()
        hud.tag = K.loadingViewTag
        hud.text = text ?? ""
        hud.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hud)
        
        hud.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hud.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        hud.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hud.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        hud.startAnimating()
    }
    
    func hideLoading() {
        view.subviews.forEach { subview in
            if subview.tag == K.loadingViewTag {
                subview.removeFromSuperview()
            }
        }
    }
}
