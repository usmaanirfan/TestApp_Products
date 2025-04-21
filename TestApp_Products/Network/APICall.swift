//
//  APICall.swift
//  TestApp_Products
//
//  Created by Mohammad Usman Ansari on 2025-04-21.
//

import Foundation

typealias HTTPCode = Int

enum Method : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol APICall {
    var path : String {get}
    var method : Method { get }
    var headers : [String: String]? { get }
    func body() throws -> Data?
}

enum APIError : Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case decodingFailed
    case imageDeserialization
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return self.localizedDescription
        case .imageDeserialization: return "Cannot deserialize image from Data"
        case .decodingFailed:
            return self.localizedDescription
        }
    }
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest{
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

extension APICall {
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    func body() throws -> Data? {
        return nil
    }
}

typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}

