//
//  APIClient.swift
//  olimpiadas
//
//  Created by Edgar Gante on 29/05/22.
//

import Foundation
import Alamofire

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder) { (response: DataResponse<T, AFError>) in
                completion(response.result)
        }
    }
    
//    static func getUserTest(id: String, completion:@escaping (Result<User, AFError>)->Void) {
//        performRequest(route: APIRouter.getUserTest(id: id), completion: completion)
//    }
    
    static func signup(id: Int, name: String, email: String, role: Int, password: String, completion:@escaping (Result<User, AFError>)->Void) {
        performRequest(route: APIRouter.signup(id: id, name: name, email: email, role: role, password: password), completion: completion)
        }
    

//    static func login(email: String, password: String, completion:@escaping (Result<User, AFError>)->Void) {
//        performRequest(route: APIRouter.login(email: email, password: password), completion: completion)
//    }
//
//    static func getArticles(completion:@escaping (Result<[Article], AFError>)->Void) {
//        let jsonDecoder = JSONDecoder()
//        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
//        performRequest(route: APIRouter.articles, decoder: jsonDecoder, completion: completion)
//    }
}


