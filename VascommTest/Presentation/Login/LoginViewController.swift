//
//  LoginViewController.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: FormTextField!
    @IBOutlet weak var passwordTextField: FormTextField!
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        emailTextField.delegate = self
        
        passwordTextField.setType(.hidePassword)
        passwordTextField.actionDelegate = self
        passwordTextField.delegate = self
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

extension LoginViewController {
    @IBAction func forgotButtonTapped(_ sender: UIButton) {}
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if let appDelegate,
           let homeViewController = appDelegate.container.resolve(HomeViewController.self),
           let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
            let navController = UINavigationController(rootViewController: homeViewController)
            sceneDelegate.window?.rootViewController = navController
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if let registerViewController = appDelegate?
            .container
            .resolve(RegisterViewController.self) {
            navigationController?
                .pushViewController(registerViewController, animated: true)
        }
    }
    
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

extension LoginViewController: FormTextFieldDelegate {
    func formTextField(_ textField: FormTextField, didButtonTappedWithType type: AuthFormTextFieldType) {
        
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
