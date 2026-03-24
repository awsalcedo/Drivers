//
//  Driver.swift
//  Drivers
//
//  Created by usradmin on 24/3/26.
//

import Foundation

struct Driver: Identifiable, Codable, Hashable, Sendable {
    
    // MARK: Properties
    
    let id: Int
    let nombre: String
    let equipo: String
    let nacionalidad: String
    let edad: Int
    let imagen: String
}
