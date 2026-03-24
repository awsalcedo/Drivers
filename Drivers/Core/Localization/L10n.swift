//
//  L10n.swift
//  Drivers
//
//  Created by usradmin on 24/3/26.
//

import Foundation

enum L10n {
    
    // MARK: - Common (Localizable.xcstrings)
    
    enum Common {
        static let ok = String(localized: "COMMON_OK")
        static let retry = String(localized: "COMMON_RETRY")
        static let loading = String(localized: "COMMON_LOADING")
    }
    
    // MARK: - Errors (Localizable.xcstrings)
    
    enum Error {
        static let title = String(localized: "ERROR_TITLE")
        static let generic = String(localized: "ERROR_GENERIC")
        static let network = String(localized: "ERROR_NETWORK")
        static let timeout = String(localized: "ERROR_TIMEOUT")
        static let server = String(localized: "ERROR_SERVER")
        static let unauthorized = String(localized: "ERROR_UNAUTHORIZED")
    }
}
