//
//  AuthRepository.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation
import Combine

final class AuthRepository: AuthRepositoryProtocol {
    var remote: AuthRemoteDataSourceProtocol
    var keychain: KeychainManager
    
    init(remote: AuthRemoteDataSourceProtocol, keychain: KeychainManager) {
        self.remote = remote
        self.keychain = keychain
    }
    
    func getToken() -> String? {
        keychain.getToken()
    }
    
    func login(model: LoginRequestModel) -> AnyPublisher<LoginResponse, Error> {
        remote.login(model: model)
    }
    
    func logout() -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { [weak self] completion in
            do {
                try self?.keychain.setToken(nil)
                completion(.success(true))
            } catch {
                completion(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
