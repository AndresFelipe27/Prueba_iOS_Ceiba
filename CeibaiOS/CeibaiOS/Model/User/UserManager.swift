//
//  UserManager.swift
//  CeibaiOS
//
//  Created by Felipe18 on 28/10/20.
//  Copyright © 2020 Felipe18. All rights reserved.
//

import Foundation

protocol UserManagerDelegate {
    func didUpdateTableUsers(users: [User])
    func didFailWithError(error: Error)
}

struct UserManager {
    
    var delegate: UserManagerDelegate?
    let baseService = BaseService()
    
    func getUsersFromApi() {
        baseService.sendRequest(endPoint: UserEndPoints.getUsers.rawValue) { (response) in
            switch response {
            case .success(let result):
                if let users = self.parseJSON(result) {
                    print(users)
                    self.delegate?.didUpdateTableUsers(users: users)
                }
                break
            case .failure:
                break
            case .responseUnsuccessfull(let code):
                print("Unsuccessfull Response -> StatusCode: \(code)")
                break
            }
        }
    }
    
    func parseJSON(_ data: Data) -> [User]? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([User].self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
}
