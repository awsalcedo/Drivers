//
//  APIEndpoints.swift
//  Drivers
//
//  Created by usradmin on 24/3/26.
//

import Foundation

enum API {
    
    static let baseURL = "https://f1demoapp.s3.eu-west-3.amazonaws.com"
    
    enum Endpoints {
        
        // MARK: Driver List
        
        static let listDrivers = "/pilotos.json"
    }
}
