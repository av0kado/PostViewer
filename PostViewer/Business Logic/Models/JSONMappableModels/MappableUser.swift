//
//  MappableUser.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

/// Mappable version of user
class MappableUser: User, JSONMappable {
    
    // MARK: - JSONMappable
    
    required init?(json: [String : Any]) {
        
        guard let id = json["id"] as? Int, let firstName = json["first_name"] as? String, let lastName = json["last_name"] as? String, let avatar = Avatar(json: json) else {
            return nil
        }
        
        super.init(id: id, firstName: firstName, lastName: lastName, avatar: avatar)
    }
}
