//
//  DriversListViewModelProtocol.swift
//  Drivers
//
//  Created by usradmin on 24/3/26.
//

import Foundation

@MainActor
protocol DriversListViewModelProtocol: Observable {
    
    // MARK: - Properties
    
    var drivers: [Driver] {get}
    
    // MARK: - Functions
    
    func loadDrivers() async
}
