//
//  NetworkService.swift
//  VascommTest
//
//  Created by Andi Septiadi on 06/09/23.
//

import Foundation
import Combine

final class NetworkService {
    static let shared = NetworkService()
    
    private func getRequest(endpoint: EndpointProtocol) throws -> URLRequest {
        let urlString = endpoint.baseURL + endpoint.path
        
        guard let urlComponent = URLComponents(string: urlString) else {
            throw AppError.server(code: nil)
        }
        
        guard let url = urlComponent.url else {
            throw AppError.custom(message: "URL nil")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        if let parameters = endpoint.parameters {
            let bodyData = try JSONSerialization.data(withJSONObject: parameters,
                                                      options: .prettyPrinted)
            urlRequest.httpBody = bodyData
        }
        
        for header in endpoint.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return urlRequest
    }
    
    
    func request<T: Decodable>(type: T.Type,
                               endpoint: EndpointProtocol) -> AnyPublisher<T, Error> {
        do {
            let request = try getRequest(endpoint: endpoint)
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result in
                    guard result.response is HTTPURLResponse else {
                        throw AppError.server(code: nil)
                    }
                    
                    let decoder = JSONDecoder()
                    return try decoder.decode(type, from: result.data)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
