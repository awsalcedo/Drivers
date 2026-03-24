//
//  Logger+Inku.swift
//  Drivers
//
//  Created by usradmin on 24/3/26.
//

import Foundation
import os

extension Logger {
    
    // MARK: - Private Properties
    
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.awsalcedo.drivers.Drivers"
    
    // MARK: - Feature Loggers
    
    /// Logger for DriverList feature
    static let driverList = Logger(subsystem: subsystem, category: "DriverList")
    
    // MARK: - Log for Core Services
    
    static let core = Logger(subsystem: subsystem, category: "Core")
}

