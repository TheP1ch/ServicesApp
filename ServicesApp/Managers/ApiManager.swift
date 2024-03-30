//
//  ApiManager.swift
//  ServicesApp
//
//  Created by Евгений Беляков on 29.03.2024.
//

import UIKit


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
    
    private let fileManager: ImageFileManager
    
    public init(fileManager: ImageFileManager) {
        self.fileManager = fileManager
    }
    
    private func getData(for url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
    
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.failedResponse
        }
        
        guard Self.httpStatusCodeSuccess.contains(response.statusCode) else {
                    throw RequestError.failedResponse
        }
        
        return data
    }
    
    func obtainServices() async throws -> [Service] {
        let requestUrl = "\(baseURL)/result.json"
        guard let url = URL(string: requestUrl) else {
            throw RequestError.invalidUrl
        }

        let data = try await self.getData(for: url)
        
        return try jsonDecoder.decode(ResponseServicesRequest.self, from: data).body.services
    }
    
    func downloadImage(for stringUrl: String) async throws -> UIImage{
        guard let url = URL(string: stringUrl) else {
            throw RequestError.invalidUrl
        }
        
        let imageName = stringUrl.replacingOccurrences(of: "\(baseURL)/", with: "")
        
        if let savedImage = fileManager.get(key: imageName){
            return savedImage
        }else {
            let imageData = try await self.getData(for: url)
            let image = UIImage(data: imageData)!
            
            fileManager.add(key: imageName, value: image)
            
            return image
        }
    }
}
