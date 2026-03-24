//
//  DriversListInteractor.swift
//  Drivers
//
//  Created by usradmin on 24/3/26.
//

import Foundation

final class DriversListInteractor: DriversListInteractorProtocol {
    
    // MARK: - Private Properties
    
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Initializers
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Functions
    
    func fetchDrivers() async throws -> DriversResponse {
        return try await networkService.get(endpoint: API.Endpoints.listDrivers)
    }
}
