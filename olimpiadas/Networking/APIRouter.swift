//
//  APIRouter.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import Foundation
import Alamofire
import AlamofireNetworkActivityLogger

struct APIConstants {
    struct ProductionServer {
        static let baseURL = "http://127.0.0.1:8000"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
        static let name = "name"
        static let role = "role"
        static let id = "id"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}


enum APIRouter: URLRequestConvertible {
    
    case signup(id: Int, name: String, email: String, password: String, role: Int)
    case login(emal: String, password: String)
    case getUser(id: Int)
    case getDisciplines
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        NetworkActivityLogger.shared.startLogging()
        switch self {
        case .signup, .login:
            return .post
        case .getUser, .getDisciplines:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .signup:
            return "/user/"
        case .login:
            return "/login/"
        case .getDisciplines, .getUser:
            return "/api/Discipline/"
        }
    }
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .signup(let id, let name, let email, let password,  let role):
            return [
                APIConstants.APIParameterKey.email: email,
                APIConstants.APIParameterKey.password: password,
                APIConstants.APIParameterKey.name: name,
                APIConstants.APIParameterKey.role: role,
                APIConstants.APIParameterKey.id: id
            ]
        case .getDisciplines:
            return nil
        
        case .login(let email, let password):
            return [
                APIConstants.APIParameterKey.email: email,
                APIConstants.APIParameterKey.password: password,
            ]
        case .getUser(let id):
            return [
                APIConstants.APIParameterKey.id: id
            ]
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try APIConstants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}

