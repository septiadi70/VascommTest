//
//  RegisterViewController.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: FormTextField!
    @IBOutlet weak var lastNameTextField: FormTextField!
    @IBOutlet weak var idCardTextField: FormTextField!
    @IBOutlet weak var emailTextField: FormTextField!
    @IBOutlet weak var phoneTextField: FormTextField!
    @IBOutlet weak var passwordTextField: FormTextField!
    @IBOutlet weak var retypeTextField: FormTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        idCardTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        
        passwordTextField.setType(.hidePassword)
        passwordTextField.actionDelegate = self
        passwordTextField.delegate = self
        
        retypeTextField.setType(.hidePassword)
        retypeTextField.actionDelegate = self
        retypeTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - Actions

extension RegisterViewController {
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {}
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

// MARK: - FormTextFieldDelegate

extension RegisterViewController: FormTextFieldDelegate {
    func formTextField(_ textField: FormTextField, didButtonTappedWithType type: AuthFormTextFieldType) {
        
    }
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
