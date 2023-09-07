//
//  MenuUseCaseProtocol.swift
//  VascommTest
//
//  Created by Andi Septiadi on 07/09/23.
//

import Foundation
import Combine

protocol MenuUseCaseProtocol {
    func getToken() -> String?
    func logout() -> AnyPublisher<Bool, Error>
}
