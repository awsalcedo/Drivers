//
//  NetworkService.swift
//  Drivers
//
//  Created by usradmin on 24/3/26.
//

import Foundation

final class NetworkService: NetworkServiceProtocol, Sendable {
    
    // MARK: Private Properties
    
    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder
    
    /// SSL Pinning delegate (retained by URLSession)
    private let piningDelegate: SSLPinningDelegate?
    
    // MARK: Initializers
    
    init(
        baseURL: URL = URL(string: API.baseURL)!,
        session: URLSession? = nil,
        enableSSLPining: Bool = true
    ) {
        self.baseURL = baseURL
        
        // SSL Pinning is disabled for test server — enable for production
        let delegate = enableSSLPining ? SSLPinningDelegate(
            pinnedHashes: [],
            isPinningEnabled: false
        ): nil
        
        self.piningDelegate = delegate
        
        
        if let session {
            self.session = session
        } else {
            self.session = URLSession(
                configuration: .default,
                delegate: delegate,
                delegateQueue: nil
            )
        }
        
        
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
    // MARK: Functions
    
    func get<T: Decodable & Sendable>(endpoint: String) async throws -> T {
        let url = baseURL.appending(path: endpoint, directoryHint: .notDirectory)
        
        guard let url = URL(string: url.absoluteString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        return try await perform(request)
    }
    
    // MARK: Private Functions
    
    private func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        let(data, response) = try await session.data(for: request)
        try validateResponse(response)
        return try decoder.decode(T.self, from: data)
    }
                            
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 403, 404:
            throw NetworkError.notFound
        case 422:
            throw NetworkError.validationError
        case 500...599:
            throw NetworkError.serverError(httpResponse.statusCode)
        default:
            throw NetworkError.unknown(httpResponse.statusCode)
        }
    }
}
