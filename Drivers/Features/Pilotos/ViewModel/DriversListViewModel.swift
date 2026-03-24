//
//  DriversListViewModel.swift
//  Drivers
//
//  Created by usradmin on 24/3/26.
//

import Foundation
import Observation
import os

@Observable
@MainActor
final class DriversListViewModel: DriversListViewModelProtocol {
    
    // MARK: - Private Properties
    
    @ObservationIgnored
    private let interactor: DriversListInteractorProtocol
    
    // MARK: - Properties
    
    var drivers: [Driver] = []
    var isLoading = false
    var errorMessage: String?
    
    // MARK: - Initializers
    
    init(interactor: DriversListInteractorProtocol = DriversListInteractor()) {
        self.interactor = interactor
    }
    
    // MARK: - Functions
    
    func loadDrivers() async {
        guard !isLoading else {return}
        
        isLoading = true
        drivers = []
        errorMessage = nil
        
        // Se usa el defer para apagar el loading
        defer {
            isLoading = false
        }
        
        do {
            let response = try await interactor.fetchDrivers()
            drivers = response.pilotos
        } catch {
            handleError(error)
        }
        
    }
    
    // MARK: - Private Functions
    
    private func handleError(_ error: Error) {
        if let networkError = error as? NetworkError {
            Logger.driverList.error("NetworkError: \(networkError, privacy: .private)")
            errorMessage = L10n.Error.generic
        } else if let urlError = error as? URLError {
            Logger.driverList.error("URLError: \(urlError.code.rawValue, privacy: .public)")
            
            switch urlError.code {
            case .notConnectedToInternet:
                errorMessage = L10n.Error.network
            case .timedOut:
                errorMessage = L10n.Error.timeout
            case .cancelled:
                return
            default:
                errorMessage = L10n.Error.generic
            }
        } else {
            Logger.driverList.error("Unknown error: \(error, privacy: .private)")
            errorMessage = L10n.Error.generic
        }
    }
    
}
