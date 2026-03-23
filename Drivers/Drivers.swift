//
//  Drivers.swift
//  Drivers
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 14/3/25.
//

// Se necesita usar decode de JSONDecoder y Bundle para eso importamos Fundation
import Foundation

struct Drivers: Decodable {
    let pilotos: [Driver]
    
    static func cargar() throws -> [Driver] {
        guard let url = Bundle.main.url(forResource: "pilotos", withExtension: "json") else {
            throw DriversError.notExist
        }
        
        let data = try Data(contentsOf: url)
        
        let drivers = try JSONDecoder().decode(Drivers.self, from: data)
        
        return drivers.pilotos
        
    }
    
    static func cargarDelServidor() async throws -> [Driver] {
        let url = URL(string: "https://f1demoapp.s3.eu-west-3.amazonaws.com/pilotos.json")!
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateResponse(response)
        let drivers = try JSONDecoder().decode(Drivers.self, from: data)
        return drivers.pilotos
    }
}

enum DriversError: Error {
    case notExist
}

struct Driver: Decodable, Identifiable, Hashable {
    let id: Int
    let nombre: String
    let equipo: String
    let nacionalidad: String
    let edad: Int
    let imagen: String
}

// MARK: Private Functions

private func validateResponse(_ response: URLResponse) throws {
    guard let httpResponse = response as? HTTPURLResponse else {
        throw NetworkError.invalidResponse
    }
    
    switch httpResponse.statusCode {
    case 200...299:
        return
    case 400:
        throw NetworkError.badRequest
    case 401:
        throw NetworkError.unauthorized
    case 404:
        throw NetworkError.notFound
    case 422:
        throw NetworkError.validationError
    case 500...599:
        throw NetworkError.serverError(httpResponse.statusCode)
    default:
        throw NetworkError.unknown(httpResponse.statusCode)
    }
}
