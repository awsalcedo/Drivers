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
    var isLoading: Bool {get}
    var errorMessage: String? {get}
    
    // MARK: - Functions
    
    func loadDrivers() async
}
