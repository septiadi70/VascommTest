//
//  AuthEndpoint.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation

enum AuthEndpoint: EndpointProtocol {
    case login(model: LoginRequestModel)
    
    var baseURL: String {
        "https://reqres.in/api"
    }
    var path: String {
        switch self {
        case .login: return "/login"
        }
    }
    var headers: [String : String] {
        switch self {
        case .login: return ["Content-Type": "application/json"]
        }
    }
    
    var method: String {
        switch self {
        case .login: return "POST"
        }
    }
    var parameters: [String : Any]? {
        switch self {
        case .login(let model): return model.bodyParameters()
        }
    }
}
