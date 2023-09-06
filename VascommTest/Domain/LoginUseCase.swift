//
//  LoginUseCase.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation
import Combine

final class LoginUseCase {
    var repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func login(email: String, password: String) -> AnyPublisher<LoginResponse, Error> {
        repository.login(model: LoginRequestModel(email: email, password: password))
    }
}
