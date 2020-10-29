//
//  PostManager.swift
//  CeibaiOS
//
//  Created by Felipe18 on 29/10/20.
//  Copyright © 2020 Felipe18. All rights reserved.
//

import Foundation

protocol PostManagerDelegate {
    func didUpdateTablePost(posts: [Post])
    func didFailWithError(error: Error)
}

struct PostManager {
    
    var delegate: PostManagerDelegate?
    
    let baseService = BaseService()
    
    func getPostByUserIdFromApi(userId: Int) {
        let endpoint = PostEndPoints.getPostsByUserId.rawValue + "\(userId)"
        
        baseService.sendRequest(endPoint: endpoint) { (response) in
            switch response {
            case .success(let result):
                if let posts = self.parseJSON(result) {
                    print(posts)
                    self.delegate?.didUpdateTablePost(posts: posts)
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
    
    func parseJSON(_ data: Data) -> [Post]? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Post].self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
}
