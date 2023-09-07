//
//  LoginViewModel.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import Foundation
import Combine

final class LoginViewModel {
    var useCase: LoginUseCaseProtocol
    var bags = Set<AnyCancellable>()
    var email = ""
    var password = ""
    
    @Published var error: Error?
    @Published var isLoading = false
    @Published var token: String?
    
    init(useCase: LoginUseCaseProtocol) {
        self.useCase = useCase
    }
    
    private func validate() -> Bool {
        if email.isEmpty {
            error = AppError.custom(message: "Email kosong")
            return false
        }
        if !email.isEmail() {
            error = AppError.custom(message: "Format email salah")
            return false
        }
        if password.isEmpty {
            error = AppError.custom(message: "Password kosong")
            return false
        }
        return true
    }
    
    func login() {
        guard validate() else { return }
        isLoading = true
        useCase
            .login(email: email, password: password)
            .flatMap { self.useCase.saveToken(token: $0.token ?? "") }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] token in
                self?.token = token
            }
            .store(in: &bags)
    }
}
