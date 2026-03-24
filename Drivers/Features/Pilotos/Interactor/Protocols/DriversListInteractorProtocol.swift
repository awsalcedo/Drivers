//
//  DriversListInteractor.swift
//  Drivers
//
//  Created by usradmin on 24/3/26.
//

import Foundation

protocol DriversListInteractorProtocol: Sendable {
    func fetchDrivers() async throws -> DriversResponse
}
