//
//  ApiManager.swift
//  ServicesApp
//
//  Created by Евгений Беляков on 29.03.2024.
//

import Foundation


enum RequestError: Error{
    case invalidUrl
    case unexpectedResponse
    case failedResponse
}

final class ApiManager {
    private let baseURL = "https://publicstorage.hb.bizmrg.com/sirius"
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return jsonDecoder
    }()
    
    private static let httpStatusCodeSuccess = 200..<300
    
    func obtainServices() async throws -> [Service] {
        let requestUrl = "\(baseURL)/result.json"
        guard let url = URL(string: requestUrl) else {
            throw RequestError.invalidUrl
        }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.failedResponse
        }
        
        guard Self.httpStatusCodeSuccess.contains(response.statusCode) else {
                    throw RequestError.failedResponse
        }
        
        return try jsonDecoder.decode(ResponseServicesRequest.self, from: data).body.services
    }
}
