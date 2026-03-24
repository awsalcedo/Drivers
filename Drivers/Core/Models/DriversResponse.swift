//
//  DriversResponse.swift
//  Drivers
//
//  Created by usradmin on 24/3/26.
//

import Foundation

struct DriversResponse: Codable, Sendable {
    
    // MARK: Properties
    
    let pilotos: [Driver]
    
}
