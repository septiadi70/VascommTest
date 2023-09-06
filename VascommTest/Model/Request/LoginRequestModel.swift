//
//  LoginRequestModel.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation

struct LoginRequestModel: RequestModelProtocol {
    var email: String
    var password: String
    
    struct K {
        static let email = "email"
        static let password = "password"
    }
    
    func bodyParameters() -> [String : Any] {
        [K.email: email, K.password: password]
    }
}
