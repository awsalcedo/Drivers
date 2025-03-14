//
//  Drivers.swift
//  Drivers
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 14/3/25.
//

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
}

enum DriversError: Error {
    case notExist
}

struct Driver: Decodable, Identifiable {
    let id: Int
    let nombre: String
    let equipo: String
    let nacionalidad: String
    let edad: Int
    let imagen: String
}
