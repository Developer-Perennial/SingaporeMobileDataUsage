//
//  DataUsageNetworkService.swift
//  DataUsage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial Sys. All rights reserved.
//

import Foundation
import Alamofire


public protocol NetworkServiceProtocol {
    
    func request<T: Decodable>(url: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders, uRLEncoding: URLEncoding, completion:@escaping (Result<T, APIError>) -> Void)
}

class DataUsageNetworkService: NetworkServiceProtocol {
    
    public func request<T: Decodable>(url: String, method: HTTPMethod, parameters: [String: Any]?, headers: HTTPHeaders, uRLEncoding: URLEncoding, completion:@escaping (Result<T, APIError>) -> Void) {
        
        if !NetworkReachabilityManager()!.isReachable {
            var apiError = APIError()
            apiError.internetNotAvailble = true
            completion(.failure(apiError))
            return
        }
        let apiUrl = Configuration.BASE_URL + url
        let request = AF.request(apiUrl, method: method, parameters: parameters, encoding: uRLEncoding, headers: headers).validate()
        
        request.responseCodable(T.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

