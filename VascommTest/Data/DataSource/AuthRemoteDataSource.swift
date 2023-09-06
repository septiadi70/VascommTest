//
//  AuthRemoteDataSource.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation
import Combine

final class AuthRemoteDataSource: AuthRemoteDataSourceProtocol {
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func login(model: LoginRequestModel) -> AnyPublisher<LoginResponse, Error> {
        networkService.request(type: LoginResponse.self,
                               endpoint: AuthEndpoint.login(model: model))
    }
}
