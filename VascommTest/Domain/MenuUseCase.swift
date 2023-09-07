//
//  MenuUseCase.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import Foundation
import Combine

final class MenuUseCase: MenuUseCaseProtocol {
    var repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func getToken() -> String? {
        repository.getToken()
    }
    
    func logout() -> AnyPublisher<Bool, Error> {
        repository.logout()
    }
}
