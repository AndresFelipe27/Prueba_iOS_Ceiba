//
//  User.swift
//  CeibaiOS
//
//  Created by Felipe18 on 28/10/20.
//  Copyright © 2020 Felipe18. All rights reserved.
//

import Foundation
import RealmSwift

//MARK: UserEntity
class User: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var phone: String?
    @objc dynamic var email: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case phone
        case email
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.email = try container.decode(String.self, forKey: .email)
    }
    
    
    
}
