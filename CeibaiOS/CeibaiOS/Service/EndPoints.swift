//
//  EndPoints.swift
//  CeibaiOS
//
//  Created by Felipe18 on 28/10/20.
//  Copyright © 2020 Felipe18. All rights reserved.
//

import Foundation

enum UserEndPoints: String {
    case getUsers = "/users"
}

enum PostEndPoints: String {
    case getPosts = "/posts"
    case getPostsByUserId = "/posts?userId="
}
