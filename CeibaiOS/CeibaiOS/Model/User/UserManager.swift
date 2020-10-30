//
//  UserManager.swift
//  CeibaiOS
//
//  Created by Felipe18 on 28/10/20.
//  Copyright © 2020 Felipe18. All rights reserved.
//

import Foundation
import RealmSwift

protocol UserManagerDelegate {
    func didUpdateTableUsers(users: [User])
    func didFailWithError(error: Error)
}

class UserManager {
    
    var delegate: UserManagerDelegate?
    let baseService = BaseService()
    let realm = try! Realm()
    var listUsers = [User]()
    
    func getUsersFromApi() {
        baseService.sendRequest(endPoint: UserEndPoints.getUsers.rawValue) { (response) in
            switch response {
            case .success(let result):
                if let users = self.parseJSON(result) {
                    print(users)
                    self.delegate?.didUpdateTableUsers(users: users)
                    print(Realm.Configuration.defaultConfiguration.fileURL)
                    //self.save(users: users)
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
    
    //Mark: - Data Manipulation Methods
    func save(users: [User]) {
        do {
            try realm.write {
                realm.add(users)
                print("Saved users")
            }
        } catch {
            print("Error saving users \(error)")
        }
    }
    
    func loadUsers() {
        //self.listUsers = realm.objects(User.self)
    }
    
    
    
    
}
