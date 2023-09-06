//
//  AuthRemoteDataSourceProtocol.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation
import Combine

protocol AuthRemoteDataSourceProtocol {
    func login(model: LoginRequestModel) -> AnyPublisher<LoginResponse, Error>
}
