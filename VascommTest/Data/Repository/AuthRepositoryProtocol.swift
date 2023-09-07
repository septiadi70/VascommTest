//
//  AuthRepositoryProtocol.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation
import Combine

protocol AuthRepositoryProtocol {
    func getToken() -> String?
    func login(model: LoginRequestModel) -> AnyPublisher<LoginResponse, Error>
    func logout() -> AnyPublisher<Bool, Error>
    func saveToken(token: String) -> AnyPublisher<String, Error>
}
