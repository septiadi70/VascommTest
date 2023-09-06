//
//  LoginResponse.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation

struct LoginResponse: Decodable {
    var token: String?
    var error: String?
}
