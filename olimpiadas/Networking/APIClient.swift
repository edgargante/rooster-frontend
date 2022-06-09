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
    
    static func signup(
        name: String, email: String, role: Int, password: String, completion: @escaping (Result<User, AFError>) -> Void) {
        performRequest(
            route: APIRouter.signup(id: 0, name: name, email: email, password: password, role: role), completion: completion)
    }
    
    static func login(email: String, password: String, completition: @escaping (Result<User, AFError>) -> Void) {
        performRequest(
            route: APIRouter.login(emal: email, password: password),
            completion: completition
        )
    }
    
    static func getUser(id: Int,  completition: @escaping (Result<User, AFError>)->Void) {
        performRequest(route: APIRouter.getUser(id: id), completion: completition)
    }
    
    static func getDisciplines(completition: @escaping (Result<[Discipline], AFError>)->Void) {
        performRequest(route: APIRouter.getDisciplines, completion: completition)
    }
}


