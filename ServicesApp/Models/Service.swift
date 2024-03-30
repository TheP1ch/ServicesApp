//
//  Service.swift
//  ServicesApp
//
//  Created by Евгений Беляков on 29.03.2024.
//

import Foundation

struct Service: Codable {
    let name: String
    let description: String
    let link: String
    let iconUrl: String
}

struct ResponseServicesRequest: Codable{
    let body: ResponseServicesRequestBody
    let status: Int
}

struct ResponseServicesRequestBody: Codable{
    let services: [Service]
}
