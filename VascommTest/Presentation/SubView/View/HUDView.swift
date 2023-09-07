//
//  HUDView.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import UIKit

class HUDView: UIView {
    lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.color = .white
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    lazy var label: UILabel = {
        let aLabel: UILabel = UILabel()
        aLabel.font = UIFont(name: Theme.FontName.semiBold, size: 12)
        aLabel.textColor = .white
        aLabel.textAlignment = .center
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        return aLabel
    }()
    
    var text: String {
        get {
            return label.text ?? ""
        }
        set {
            label.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
    }
    
    final func setupView() {
        
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let wrapperView: UIView = UIView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(wrapperView)
        wrapperView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        wrapperView.addSubview(loadingView)
        loadingView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        loadingView.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor).isActive = true
        
        stackView.addArrangedSubview(label)
    }
    
    final func startAnimating() {
        loadingView.startAnimating()
    }

}
