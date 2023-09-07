//
//  LoginUseCaseProtocol.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation
import Combine

protocol LoginUseCaseProtocol {
    func login(email: String, password: String) -> AnyPublisher<LoginResponse, Error>
    func saveToken(token: String) -> AnyPublisher<String, Error>
}
