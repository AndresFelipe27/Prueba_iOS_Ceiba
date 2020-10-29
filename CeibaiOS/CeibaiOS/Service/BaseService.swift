//
//  BaseService.swift
//  CeibaiOS
//
//  Created by Felipe18 on 28/10/20.
//  Copyright © 2020 Felipe18. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceResponse {
    case success(response: Data)
    case failure
    case responseUnsuccessfull(code: Int)
}

typealias RequestCompletion = ( (_ response: ServiceResponse) -> Void )

class BaseService {
    
    func sendRequest(endPoint: String, completion: @escaping RequestCompletion) {
        let url = Constants.baseUrl + endPoint
        
        AF.request(url, method: .get).response { (response) in
            if let error = response.error {
                print("Failed to get the JSON users: ", error.localizedDescription)
                completion(.failure)
                return
            }
            
            if let response = response.response {
                if response.statusCode != 200 {
                    completion(.responseUnsuccessfull(code: response.statusCode))
                }
            }
            
            if let data = response.data {
                completion(.success(response: data))
            }
        }
    }
    
}

