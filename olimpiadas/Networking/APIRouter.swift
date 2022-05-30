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
        static let baseURL = "http://0.0.0.0:3000/olimpiadas"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
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
    
    case login(email:String, password:String)
    case articles
    case getUserTest(id: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .articles, .getUserTest:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "/users/1"
        case .articles:
            return "/articles/all.json"
        case .getUserTest(let id):
            return "/users/\(id)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        NetworkActivityLogger.shared.startLogging()
        switch self {
        case .login(let email, let password):
            return [APIConstants.APIParameterKey.email: email, APIConstants.APIParameterKey.password: password]
        case .articles, .getUserTest:

            enum APIRouter: URLRequestConvertible {
                
                case login(email:String, password:String)
                case articles
                case getUserTest(id: Int)
                
                // MARK: - HTTPMethod
                private var method: HTTPMethod {
                    switch self {
                    case .login:
                        return .post
                    case .articles, .getUserTest:
                        return .get
                    }
                }
                
                // MARK: - Path
                private var path: String {
                    switch self {
                    case .login:
                        return "/login"
                    case .articles:
                        return "/articles/all.json"
                    case .getUserTest(let id):
                        return "users/\(id)"
                    }
                }
                
                // MARK: - Parameters
                private var parameters: Parameters? {
                    switch self {
                    case .login(let email, let password):
                        return [APIConstants.APIParameterKey.email: email, APIConstants.APIParameterKey.password: password]
                    case .articles, .getUserTest:
                        return nil
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


            return nil
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

