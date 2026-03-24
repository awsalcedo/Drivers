//
//  NetworkError.swift
//  Drivers
//
//  Created by usradmin on 23/3/26.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case badRequest
    case unauthorized
    case notFound
    case validationError
    case serverError(Int)
    case unknown(Int)
    
    /*var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL no es válida."
        case .invalidResponse:
            return "La respuesta del servidor no es válida."
        case .badRequest:
            return "La solicitud es incorrecta."
        case .unauthorized:
            return "No autorizado."
        case .notFound:
            return "No se encontró el recurso solicitado."
        case .validationError:
            return "Error de validación."
        case .serverError(let code):
            return "Error del servidor (\(code)."
        case .unknown(let code):
            return "Error desconocido (\(code)."
        }
    }*/
}
