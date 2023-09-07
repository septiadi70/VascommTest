//
//  FormTextField.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import UIKit

enum AuthFormTextFieldType {
    case basic
    case showPassword
    case hidePassword
    
    var icon: UIImage? {
        switch self {
        case .showPassword: return UIImage(named: "fluent_eye-show-12-filled")?
                .withRenderingMode(.alwaysTemplate)
        case .hidePassword: return UIImage(named: "fluent_eye-show-12-filled")?
                .withRenderingMode(.alwaysTemplate)
        default: return nil
        }
    }
}

protocol FormTextFieldDelegate: AnyObject {
    func formTextField(_ textField: FormTextField, didButtonTappedWithType type: AuthFormTextFieldType)
}

class FormTextField: UITextField {
    weak var actionDelegate: FormTextFieldDelegate?
    
    private let padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    private var formType = AuthFormTextFieldType.basic
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 1)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 16.0
        return rect
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 5
    }
    
    func setActive(_ value: Bool) {
        layer.borderWidth = value ? 1.0 : 0.0
    }
    
    func setType(_ value: AuthFormTextFieldType) {
        formType = value
        eyeButton.setImage(value.icon, for: .normal)
        
        switch value {
        case .basic:
            rightViewMode = .never
            rightView = nil
            isSecureTextEntry = false
            textContentType = .none
            
        case .showPassword:
            rightViewMode = .always
            rightView = eyeButton
            isSecureTextEntry = false
            textContentType = .none
            
        case .hidePassword:
            rightViewMode = .always
            rightView = eyeButton
            isSecureTextEntry = true
            textContentType = .oneTimeCode
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        actionDelegate?.formTextField(self, didButtonTappedWithType: formType)
    }
    
    private func configureUI() {
        backgroundColor = UIColor.white
        font = UIFont(name: Theme.FontName.regular, size: 12.0)
        layer.cornerRadius = 8.0
        
        textColor = .black
        
        setType(.basic)
        
        returnKeyType = .done
    }
}
