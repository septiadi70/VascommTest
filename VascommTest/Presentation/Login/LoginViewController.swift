//
//  LoginViewController.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import UIKit
import Combine

class LoginViewController: UIViewController, HUDLoadable {
    var viewModel: LoginViewModel
    var bags = Set<AnyCancellable>()
    
    @IBOutlet weak var emailTextField: FormTextField!
    @IBOutlet weak var passwordTextField: FormTextField!
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        emailTextField.delegate = self
        
        passwordTextField.setType(.hidePassword)
        passwordTextField.actionDelegate = self
        passwordTextField.delegate = self
        
        configBinding()
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

// MARK: - Methods

extension LoginViewController {
    func configBinding() {
        viewModel
            .$token
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.didLogin()
            }
            .store(in: &bags)
        
        viewModel
            .$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                guard let self, let error else { return }
                Alert.basicAlert(title: "Login", message: error.localizedDescription.capitalized)
                    .show(parentViewController: self)
                self.viewModel.error = nil
            }
            .store(in: &bags)
        
        viewModel
            .$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                if isLoading {
                    self.showLoading("Login...")
                } else {
                    self.hideLoading()
                }
            }
            .store(in: &bags)
    }
    
    func didLogin() {
        if let appDelegate,
           let homeViewController = appDelegate.container.resolve(HomeViewController.self),
           let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
            let navController = UINavigationController(rootViewController: homeViewController)
            sceneDelegate.window?.rootViewController = navController
        }
    }
}

// MARK: - Actions

extension LoginViewController {
    @IBAction func forgotButtonTapped(_ sender: UIButton) {}
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        viewModel.login()
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
        switch type {
        case .hidePassword: textField.setType(.showPassword)
        case .showPassword: textField.setType(.hidePassword)
        default: break
        }
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            viewModel.email = textField.text ?? ""
        }
        if textField == passwordTextField {
            viewModel.password = textField.text ?? ""
        }
    }
}
