//
//  EndpointProtocol.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var method: String { get }
    var parameters: [String: Any]? { get }
}
